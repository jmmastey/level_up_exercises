class CurrentWeather < ActiveRecord::Base
  validates :station_id, uniqueness: true
end
