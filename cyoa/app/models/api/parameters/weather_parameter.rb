require './app/helpers/private_attr_accessor'
require './app/models/api/parameters/weather_conditions_parameter'
require './app/models/api/parameters/time_layout_parameter'

class WeatherParameter
  extend PrivateAttrAccessor
  private_attr_accessor :weather
  attr_reader :name, :weather_conditions, :time_layout

  def initialize(new_weather)
    self.weather = new_weather
    @name = weather[:name]
    @time_layout = weather[:@time_layout]
  end

  def weather_conditions
    weather[:weather_conditions].each_with_object([]) do |key, final|
      if key.nil?
        final << key
      else
        final << weather_conditions_builder.new(key[:value])
      end
    end
  end

  private

  def weather_conditions_builder
    WeatherConditionsParameter
  end
end