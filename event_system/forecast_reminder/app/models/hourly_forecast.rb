class HourlyForecast < ActiveRecord::Base
  validates_uniqueness_of :time, scope: :zip_code

  def wind_direction_string
    Geocoder::Calculations.compass_point(wind_direction)
  end

  def self.for_zip_code(zip_code, start_time = nil)
    start_time ||= Time.now.beginning_of_hour
    where(zip_code: zip_code).where(time: start_time...(start_time + 1.days))
      .order(:time).all
  end
end
