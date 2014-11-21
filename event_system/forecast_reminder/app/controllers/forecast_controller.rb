class ForecastController < ApplicationController
  def index
    @conditions = conditions unless params.include? :start_time
    @forecasts = Forecast.for_zip_code(zip_code, start_time)
    @hourly_forecast = HourlyForecast.for_zip_code(zip_code, start_time)
  end

  private

  def zip_code
    user_signed_in? ? current_user.zip_code : Location::DEFAULT_ZIP_CODE
  end

  def station_id
    user_signed_in? ? current_user.station_id : Location::DEFAULT_STATION_ID
  end

  def start_time
    params[:start_time].try(:to_time) || Time.now.beginning_of_hour
  end

  def conditions
    CurrentWeather.find_by_station_id(station_id)
  end
end
