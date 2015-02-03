require 'nori'
require 'savon'
require './app/models/api/nws_request.rb'
require './app/models/api/lat_lon_zipcode_client_response'

class LatLonZipcodeClient
  extend Savon::Model

  client wsdl: NWSRequest::WSDL, convert_request_keys_to: NWSRequest::REQUEST_KEYS
  operations :lat_lon_list_zip_code

  def request(zip_code_list)
    response_builder.new(lat_lon_list_zip_code(zip_code_list), zip_code_list)
  end

  private

  def lat_lon_list_zip_code(zip_code_list)
    validate_zip_code_list(zip_code_list)
    super(message: { zip_code_list: zip_code_list })
  end

  def zip_code_list_is_valid?(zip_code_list)
    zip_code_list =~ /\d{5}(\-\d{4})?( \d{5}(\-\d{4})?)*/
  end

  def validate_zip_code_list(zip_code_list)
    raise LatLonZipcodeError, "Invalid zip code format" unless zip_code_list_is_valid?(zip_code_list)
  end

  def response_builder
    LatLonZipcodeClientResponse
  end
end

class LatLonZipcodeError < StandardError
end