
class WeatherController < ApplicationController
  include ParseWeather
  def index
    if params["region"] && params["region"]["name"] != ""
      @high_low_temperatures = ParseTemperatures.call
      @detail_forecasts = ParseDetails.call
      puts @detail_forecasts
      puts @high_low_temperatures
      #forecast_now = Hash[*@detail_forecasts.values].values[0].downcase

    end
  end

  def show
  end
end
