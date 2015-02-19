class ForecastWeatherType < ActiveRecord::Base
  belongs_to :forecast
  belongs_to :weather_type

  def formatted_weather
    
  end
end
