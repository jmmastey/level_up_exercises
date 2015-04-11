
class WeatherController < ApplicationController
  def index
    if params["region"] && params["region"]["name"] != ""
      @high_low_temperatures = ParseTemperatures.call
      puts @high_low_temperatures
      @detail_forecasts = ParseDetails.call
    end
  end

  def show
  end
end
