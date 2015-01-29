require 'nori'
require 'savon'
require './app/models/nws_request.rb'

class WeatherRequest
  extend Savon::Model
  attr_reader :response

  # Ref: graphical.weather.gov/xml/
  # "glance" returns all data between the start and end times
  # for the parameters maxt, mint, sky, wx, and icons
  DEFAULT_PRODUCT = "glance"

  # "e" is English, "m" is Metric
  DEFAULT_UNIT = "e"
  PARAMETER_CONTAINER = :dwml

  client wsdl: NWSRequest::WSDL, convert_request_keys_to: NWSRequest::REQUEST_KEYS
  operations :NDFDgen_lat_lon_list

  def initialize(inputs = {})
    @inputs = inputs
    @response = NDFDgen_lat_lon_list
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
    
  end

  def NDFDgen_lat_lon_list(inputs = {})
    super(message: { list_lat_lon:       inputs.fetch(:list_lat_lon, null),
                     product:            inputs.fetch(:product, DEFAULT_PRODUCT),
                     start_time:         inputs.fetch(DateTime.iso8601(start_time), null),
                     end_time:           inputs.fetch(DateTime.iso8601(end_time), null),
                     unit:               inputs.fetch(:unit, DEFAULT_UNIT),
                     weather_parameters: inputs.fetch(:weather_parameters, null) })
  end
end
