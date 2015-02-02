require './app/models/parameters/weather_conditions_parameter'
require './app/models/parameters/time_layout_parameter'

class WeatherParameter
  attr_reader :name, :weather_conditions, :time_layout

  def initialize(weather)
    @name = weather[:name]
    @weather_conditions = weather[:weather_conditions]
    @time_layout = weather[:@time_layout]
  end

  def weather_conditions
    @weather_conditions.each_with_object([]) do |key, final|
      if key.nil?
        final << key
      else
        final << WeatherConditionsParameter.new(key[:value])
      end
    end
  end
end