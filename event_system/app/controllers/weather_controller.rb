
class WeatherController < ApplicationController
  include WeatherHelper
  def index
    @high_low_temperatures = WeatherHelper.parse_temperatures
    @detail_forecasts = WeatherHelper.parse_details
  end

  def show
  end
end
