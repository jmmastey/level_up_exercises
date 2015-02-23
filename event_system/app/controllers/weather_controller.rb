
class WeatherController < ApplicationController
  include ParseWeather
  def index
    if params["region"] && params["region"]["name"] != ""
      @high_low_temperatures = parse_temperatures
      @detail_forecasts = parse_details
      region_id = Region.where(city: "Chicago").pluck(:region_id)

      todays_forecast = Hash[*@detail_forecasts.values].values[0].downcase

      @todays_forecast = WEATHER_WEAR.keys.select do |word|
        todays_forecast.match(word)
      end.first.capitalize

      @user = EmailContact.where(region_id: region_id)
      WeatherAlert.weather_alert(@user, @todays_forecast).deliver
    end
  end

  def show
  end
end
