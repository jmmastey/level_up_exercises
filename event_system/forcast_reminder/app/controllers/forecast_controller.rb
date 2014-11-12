class ForecastController < ApplicationController
  def index
    @conditions = CurrentWeather.find_by_station_id('KMDW')
    @forecasts = Forecast.where(zip_code: 60606).
      where("date > ?", Date.today.to_time.utc).
      order(:date).all
    @hourly_forecast = HourlyForecast.where(zip_code: 60606).
      where("time > ?", Time.zone.now.beginning_of_hour).
      order(:time).all
  end
end
