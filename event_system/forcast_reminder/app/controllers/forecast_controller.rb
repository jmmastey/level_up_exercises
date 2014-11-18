class ForecastController < ApplicationController
  def index
    @conditions = conditions unless params.include? :start_time
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

  def start_time
    Time.parse(params.fetch(:start_time, Time.now.utc.to_s))
  end

  def conditions
    CurrentWeather.find_by_station_id(station_id)
  end

  def forecasts
    Forecast.where(zip_code: zip_code)
      .where(time: start_time..(start_time + 7.days))
      .order(:time).all
  end

  def hourly_forecast
    HourlyForecast.where(zip_code: zip_code)
      .where(time: start_time..(start_time + 1.days))
      .order(:time).all
  end
end
