class LatLonZipcodeClientResponse
  attr_reader :response, :zip_code_list
  PARAMETER_CONTAINER = :dwml

  def initialize(soap_response, zip_code_list)
    @zip_code_list = zip_code_list
    @response = soap_response
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
    merge_zip_code_with_lat_lon.each_with_object({}) do |(key, value), all|
      all[key] = value.split(",").map(&:to_f)
    end
  end

  private

  def body_parser
    @body_parser ||= Nori.new(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
  end

  def merge_zip_code_with_lat_lon
    Hash[zip_code_list.split(" ").zip lat_lon_list.split(" ")]
  end

  def lat_lon_list_is_valid?
    lat_lon_list =~ /[\-]?\d{1,2}\.\d+,[\-]?\d{1,3}\.\d+( [\-]?\d{1,2}\.\d+,[\-]?\d{1,3}\.\d+)*/
  end

  def validate_lat_lon_list
    raise LatLonZipcodeClientResponseError, "Invalid return lat lon list" unless lat_lon_list_is_valid?
  end
end

class LatLonZipcodeClientResponseError < StandardError
end