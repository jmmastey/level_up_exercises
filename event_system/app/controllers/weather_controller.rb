
class WeatherController < ApplicationController
  def index
    if params["region"] && params["region"]["name"] != ""
      @high_low_temperatures = ParseTemperatures.call
      @detail_forecasts = ParseDetails.call
    end
  end

  def show
  end
end
