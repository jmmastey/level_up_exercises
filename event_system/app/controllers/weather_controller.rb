
class WeatherController < ApplicationController
  include WeatherHelper
  def index
    if params["region"] && params["region"]["name"] != ""
      @high_low_temperatures = WeatherHelper.parse_temperatures
      @detail_forecasts = WeatherHelper.parse_details
    end
  end

  def show
  end
end
