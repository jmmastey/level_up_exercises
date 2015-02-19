require './app/models/forecast'
require './app/models/api_data_transfer/weather_refresher'

class HomeController < ApplicationController
  def index
    WeatherRefresher.refresh_if_needed
    @forecast_daily = Forecast.daily_for_next_week
    @forecast_three_hour = Forecast.three_hour_for_next_week
  end
end
