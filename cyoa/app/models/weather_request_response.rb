require 'nori'
require './app/models/weather_data'

class WeatherRequestResponse
  attr_reader :response_hash

  def initialize(response)
    @response_hash = make_response_hash(response)
  end

  def product
    head[:product]
  end

  def weather_data
    weather_data_builder.new(data)
  end

  private

  def dwml
    response_hash[:dwml_out][:dwml]
  end

  def head
    dwml[:head]
  end

  def data
    dwml[:data]
  end

  def make_response_hash(response)
    body_response_layer(response).each_with_object({}) do |(key, value), build_hash|
      build_hash[key] = body_parser.parse(value)
    end
  end

  def body_response_layer(response)
    response.body.values[0]
  end

  def body_parser
    @body_parser ||= Nori.new(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
  end

  def weather_data_builder
    WeatherData
  end
end