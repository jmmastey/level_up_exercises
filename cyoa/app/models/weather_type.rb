class WeatherType < ActiveRecord::Base
  has_many :forecast_weather_types
  has_many :forecasts, through: :forecast_weather_types
end
