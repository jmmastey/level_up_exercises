class ForecastType < ActiveRecord::Base  
  has_many :forecasts

  scope :daily, -> { where(forecast_type: '24-hour') }
  scope :three_hour, -> { where(forecast_type: "3-hour") }  

  def self.needs_refresh?
    daily_needs_refresh? || three_hour_needs_refresh?
  end

  def self.daily_needs_refresh?
    daily.first.last_refresh_start_time.nil? || daily.first.last_refresh_start_time < 24.hours.ago
  end

  def self.three_hour_needs_refresh?
    three_hour.first.last_refresh_start_time.nil? || three_hour.first.last_refresh_start_time < 24.hours.ago
  end
end
