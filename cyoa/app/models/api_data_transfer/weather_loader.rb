require './app/models/point'
require './app/models/forecast'
require './app/models/weather_type'
require './app/models/forecast_weather_type'
require './app/models/api/weather_client'
require './app/models/api_data_transfer/time_key_builder'
require './app/models/api_data_transfer/forecast_refresher'
require './app/models/api_data_transfer/forecast_type_refresher'

module WeatherLoader
  def self.load(inputs = {})
    response = requester.new.request(inputs)
    load_points(response)
  end

  private

  def self.load_points(response)
    ActiveRecord::Base.transaction do
      response.weather_data.applicable_locations.each_with_index do |location_key, index|
        location = location_by_key(response, location_key)
        point = Point.where("round(lat, 2) = #{location.latitude}",
                            "round(lon, 2) = #{location.longitude}").first
        load_point_times(response, { point: point, point_index: index })
      end
    end
  end

  def self.location_by_key(response, location_key)
    response.weather_data.locations.select { |location| location.location_key == location_key }.first
  end

  def self.load_point_times(response, load_params = {})
    times = TimeKeyBuilder.times(response.weather_data.time_layouts)
    times.each do |key, value|
      load_params.merge!({ time_key: key,
                          time_value: value })
      ForecastRefresher.refresh!(response, load_params)
    end
    ForecastTypeRefresher.refresh!(times)
  end

  def self.requester
    WeatherClient
  end
end

class WeatherLoaderError < StandardError
end