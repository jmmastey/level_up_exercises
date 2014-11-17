class ForecastController < ApplicationController
  def index
    @conditions = conditions
    @forecasts = forecasts
    @hourly_forecast = hourly_forecast
  end

  private

  def zip_code
    user_signed_in? ? current_user.zip_code : Location::DEFAULT_ZIP_CODE
  end

  def station_id
    user_signed_in? ? current_user.station_id : Location::DEFAULT_STATION_ID
  end

  def conditions
    CurrentWeather.find_by_station_id(station_id)
  end

  def forecasts
    Forecast.where(zip_code: zip_code)
      .where("time > ?", Time.now.utc)
      .order(:time).all
  end

  def hourly_forecast
    HourlyForecast.where(zip_code: zip_code)
      .where("time > ?", Time.zone.now.beginning_of_hour)
      .order(:time).all
  end
end
