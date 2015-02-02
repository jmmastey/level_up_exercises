require 'nori'
require './app/models/parameters/weather_parameter'
require './app/models/parameters/time_layout_parameter'

class WeatherRequestResponse
  attr_reader :response_hash
  MAXT_NAME = "Daily Maximum Temperature"
  MINT_NAME = "Daily Minimum Temperature"
  CLOUD_COVER_NAME = "Cloud Cover Amount"

  def initialize(response)
    @response_hash = make_response_hash(response)
  end

  def keys(hash)
    hash.each_with_object([]) do |(key, value), keys|
      keys << key
    end
  end

  def dwml
    response_hash[:dwml_out][:dwml]
  end

  def head
    dwml[:head]
  end

  def data
    dwml[:data]
  end

  def location
    data[:location]
  end

  def product
    head[:product]
  end

  def time_layouts
    data[:time_layout].each_with_object([]) do |layout, all_layouts|
      all_layouts << TimeLayoutParameter.new(layout)
    end
  end

  def parameters
    data[:parameters]
  end

  def temperatures
    parameters[:temperature]
  end

  def maxt
    temperatures.select { |key| key[:name] == MAXT_NAME }.first[:value]
  end

  def mint
    temperatures.select { |key| key[:name] == MINT_NAME }.first[:value]
  end

  def cloud_cover
    parameters[:cloud_amount][:value]
  end

  def weather
    parameters[:weather]
    # WeatherParameter.new(parameters[:weather])
  end

  # def weather_conditions
  #   parameters[:weather][:weather_conditions].map(&:values).flatten.each_with_object([]) do |value, final|
  #     final << value if value.nil?
  #     unless value.nil?
  #       final << value.each_with_object({}) do |(key, value), value_final|
  #                   value_final[key.to_s.sub('@','').to_sym] = value
  #                end
  #     end
  #   end
  # end

  private

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
end