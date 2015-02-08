class Forecast < ActiveRecord::Base
  scope :daily, -> { joins(:forecast_types).merge(ForecastType.daily) }
  scope :three_hour, -> { joins(:forecast_types).merge(ForecastType.three_hour) }
end
