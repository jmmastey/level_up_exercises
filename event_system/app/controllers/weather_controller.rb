
class WeatherController < ApplicationController
  include WeatherHelper
  def index
    if params["region"] && params["region"]["name"] != ""
      @high_low_temperatures = WeatherHelper.parse_temperatures
      @detail_forecasts = WeatherHelper.parse_details
      region_id = Region.where(:city => "Chicago").first.region_id

      today_forecast = WEATHER_WEAR.keys.select do |word|
        @detail_forecasts.last.last.values.first.downcase.match(word)
      end
      @user = EmailContact.where(region_id: region_id)
      @todays_forecast = today_forecast.first.capitalize
      WeatherAlert.weather_alert(@user, @todays_forecast).deliver
    end
  end

  def show
  end
end
