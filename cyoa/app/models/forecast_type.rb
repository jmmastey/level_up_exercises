class ForecastType < ActiveRecord::Base
  belongs_to :forecast

  scope :daily, -> { where(forecast_type: '24-hour') }
  scope :three_hour, -> { where(forecast_type: "3-hour") }
end
