require './app/models/api/parameters/location_parameter'
require './app/models/api/parameters/weather_parameter'
require './app/models/api/parameters/time_layout_parameter'
require './app/models/api/parameters/temperature_parameter'
require './app/models/api/parameters/cloud_cover_parameter'
require './app/models/api/parameters/conditions_icon_parameter'

class WeatherData
  attr_reader :data,
              :locations,
              :time_layouts,
              :weather,
              :temperatures,
              :cloud_covers,
              :conditions_icons,
              :applicable_locations

  def initialize(new_data)
    @data = new_data
    @weather = []
    @temperatures = []
    @cloud_covers = []
    @conditions_icons = []
    @applicable_locations = []
    parse_parameters
  end

  def locations
    build_parameter_list(data[:location], location_builder)
  end

  def time_layouts
    build_parameter_list(data[:time_layout], time_layout_builder)
  end

  private

  def parse_parameters
    parameters.each do |parameter_set|
      @weather << weather_builder.new(parameter_set[:weather])
      @temperatures << temperature_builder.new(parameter_set[:temperature])
      @cloud_covers << cloud_cover_builder.new(parameter_set[:cloud_amount])
      @conditions_icons << conditions_icon_builder.new(parameter_set[:conditions_icon])
      @applicable_locations << parameter_set[:@applicable_location]
    end
  end

  def make_array_if_not(var)
    return var if var.class == Array
    [var]
  end

  def parameters
    make_array_if_not(data[:parameters])
  end

  def build_parameter_list(parameter_set, parameter_builder)
    parameter_set = make_array_if_not(parameter_set)
    parameter_set.each_with_object([]) do |parameter, all|
      all << parameter_builder.new(parameter)
    end
  end

  def time_layout_builder
    TimeLayoutParameter
  end

  def location_builder
    LocationParameter
  end

  def weather_builder
    WeatherParameter
  end

  def temperature_builder
    TemperatureParameter
  end

  def cloud_cover_builder
    CloudCoverParameter
  end

  def conditions_icon_builder
    ConditionsIconParameter
  end
end