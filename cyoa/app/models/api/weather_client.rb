require 'time'
require 'nori'
require 'savon'
require './app/models/api/nws_client'
require './app/models/api/weather_client_response'
require 'pry'

class WeatherClient
  extend Savon::Model
  attr_reader :inputs, :message_inputs

  # Ref: graphical.weather.gov/xml/
  # "glance" returns all data between the start and end times
  # for the parameters maxt, mint, sky, wx, and icons
  DEFAULT_PRODUCT = "glance"

  # "e" is English, "m" is Metric
  DEFAULT_UNIT = "e"
  PARAMETER_CONTAINER = :dwml

  client wsdl: NWSClient::WSDL, convert_request_keys_to: NWSClient::REQUEST_KEYS
  operations :ndf_dgen_lat_lon_list

  def request(inputs = {})
    @error_messages = []
    @inputs = inputs
    @message_inputs = build_message_inputs
    check_errors
    WeatherClientResponse.new(ndf_dgen_lat_lon_list)
  end

  private

  attr_reader :error_messages

  def default_start_time
    Time.now
  end

  def default_end_time
    Time.now + (1*7*24*60*60)
  end

  def ndf_dgen_lat_lon_list
    super(message: message_inputs)
  end

  def build_message_inputs
    new_inputs = {}
    new_inputs[:list_lat_lon] = list_lat_lon
    new_inputs[:product] = product
    new_inputs[:start_time] = start_time
    new_inputs[:end_time] = end_time
    new_inputs[:unit] = unit
    new_inputs[:weather_parameters] = weather_parameters unless weather_parameters.nil?
    new_inputs
  end

  def list_lat_lon
    inputs.fetch(:list_lat_lon)
  end

  def product
    inputs.fetch(:product, DEFAULT_PRODUCT)
  end

  def start_time
    Time.parse(inputs.fetch(:start_time, default_start_time)).iso8601
  end

  def end_time
    Time.parse(inputs.fetch(:end_time, default_end_time)).iso8601
  end

  def unit
    inputs.fetch(:unit, DEFAULT_UNIT)
  end

  def weather_parameters
    inputs.fetch(:weather_parameters, nil)
  end

  def validate_message_inputs
     @error_messages << ":list_lat_lon required" if message_inputs[:list_lat_lon].nil?
     @error_messages << ":start_time required" if message_inputs[:start_time].nil?
     @error_messages << ":end_time required" if message_inputs[:end_time].nil?
  end

  def error_messages
    @error_messages.join(", ")
  end

  def check_errors
    raise WeatherClientError, error_messages unless error_messages.empty?
  end
end

class WeatherClientError < StandardError
end