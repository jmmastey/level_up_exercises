require './app/models/point'
require './app/models/forecast'
require './app/models/api/weather_client'
require './app/models/api_data_transfer/weather_loader'

class HomeController < ApplicationController
  DEFAULT_ZIP = "60606"

  def index
    refresh_weather_if_needed
    @forecast_daily = Forecast.daily_for_next_week
    @forecast_three_hour = Forecast.three_hour_for_next_week
  end

  def self.default_lat_lon
    point = Point.where(zip: DEFAULT_ZIP).first
    "#{point.lat.to_s}#{WeatherClient::LAT_LON_DELIMITER}#{point.lon.to_s}"
  end

  def refresh_weather_if_needed
    if ForecastType.needs_refresh?
      WeatherLoader.load(WeatherClient, list_lat_lon: self.class.default_lat_lon)
    end
  end
end
