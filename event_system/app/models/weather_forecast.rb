class WeatherForecast < ActiveRecord::Base
  scope :today, -> { where( "created_at::date = ?", Time.now.utc.to_date ) }
end
