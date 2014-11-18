class HourlyForecast < ActiveRecord::Base
  validates_uniqueness_of :time, scope: :zip_code

  def wind_direction_string
    Geocoder::Calculations.compass_point(wind_direction)
  end
end
