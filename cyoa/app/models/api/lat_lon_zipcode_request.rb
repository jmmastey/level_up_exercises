require 'nori'
require 'savon'
require './app/models/api/nws_request.rb'

class LatLonZipcodeRequest
  extend Savon::Model
  attr_reader :zip_code_list, :response
  PARAMETER_CONTAINER = :dwml

  client wsdl: NWSRequest::WSDL, convert_request_keys_to: NWSRequest::REQUEST_KEYS
  operations :lat_lon_list_zip_code

  def initialize(zip_code_list)
    @zip_code_list = zip_code_list
    validate_zip_code_list
    @response = lat_lon_list_zip_code
    validate_lat_lon_list
  end

  def body_response
    response.body.values[0]
  end

  def body_response_hash
    body_response.each_with_object({}) do |(key, value), build_hash|
      build_hash[key] = body_parser.parse(value)
    end
  end

  def response_parameters
    body_response_hash.fetch(:list_lat_lon_out).fetch(PARAMETER_CONTAINER)
  end

  def lat_lon_list
    response_parameters.fetch(:lat_lon_list)
  end

  def zip_code_lat_lon
    Hash[zip_code_list.split(" ").zip lat_lon_list.split(" ")]
  end

  private

  def lat_lon_list_zip_code
    super(message: { zip_code_list: zip_code_list })
  end

  def body_parser
    @body_parser ||= Nori.new(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
  end

  def zip_code_list_is_valid?
    zip_code_list =~ /\d{5}(\-\d{4})?( \d{5}(\-\d{4})?)*/
  end

  def validate_zip_code_list
    raise LatLonZipcodeError, "Invalid zip code format" unless zip_code_list_is_valid?
  end

  def lat_lon_list_is_valid?
    lat_lon_list =~ /[\-]?\d{1,2}\.\d+,[\-]?\d{1,3}\.\d+( [\-]?\d{1,2}\.\d+,[\-]?\d{1,3}\.\d+)*/
  end

  def validate_lat_lon_list
    raise LatLonZipcodeError, "Invalid return lat lon list" unless lat_lon_list_is_valid?
  end
end

class LatLonZipcodeError < StandardError
end