class ForecastController < ApplicationController
  def index
    zip_code = 60606
    station_id = "KMDW"
    
    if user_signed_in?
      zip_code = current_user.zip_code
      station_id = current_user.station_id
    end

    @conditions = CurrentWeather.find_by_station_id(station_id)
    @forecasts = Forecast.where(zip_code: zip_code).
      where("date > ?", Time.now.utc).
      order(:date).all
    @hourly_forecast = HourlyForecast.where(zip_code: zip_code).
      where("time > ?", Time.zone.now.beginning_of_hour).
      order(:time).all
  end
end
