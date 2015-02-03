
class WeatherController < ApplicationController
  include WeatherHelper
  def index
    if params["region"] && params["region"]["name"] != ""
      @high_low_temperatures = WeatherHelper.parse_temperatures
      @detail_forecasts = WeatherHelper.parse_details
      region_id = Region.where(:city => "Chicago").first.region_id

      WeatherAlert.weather_alert(EmailContact.where(region_id: region_id),
        @detail_forecasts).deliver
    end
  end

  def show
  end
end
