require 'active_support/all'

class Forecast < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  belongs_to :forecast_type
  has_many :forecast_weather_types
  has_many :weather_types, through: :forecast_weather_types
  
  scope :daily, -> { joins(:forecast_type).merge(ForecastType.daily) }
  scope :three_hour, -> { joins(:forecast_type).merge(ForecastType.three_hour) }
  scope :daily_for_next_week, -> do 
      joins(:forecast_type)
      .merge(ForecastType.daily)
      .where("start_time >= :start", { start: beginning_of_today })
      .where("end_time <= :end", { end: end_of_week })
      .order(:start_time)
  end
  scope :three_hour_for_next_week, -> do 
      joins(:forecast_type)
      .merge(ForecastType.three_hour)
      .where("start_time >= :start", { start: beginning_of_three_hour })
      .where("end_time <= :end", { end: end_of_week })
      .order(:start_time)
  end

  def start_date_in_app_time_zone
    self.start_time.in_time_zone.to_date.to_formatted_s(:long_ordinal)
  end

  def end_date_in_app_time_zone
    self.end_time.in_time_zone.to_date.to_formatted_s(:long_ordinal)
  end  

  def start_time_in_app_time_zone
    self.start_time.in_time_zone.strftime("%-I:%M %p")
  end

  def end_time_in_app_time_zone
    self.end_time.in_time_zone.strftime("%-I:%M %p")
  end

  def cloud_cover_pct
    number_to_percentage(self.cloud_cover, precision: 0)
  end

  def self.beginning_of_today
    Time.now.beginning_of_day
  end

  def self.end_of_week
    Time.now.end_of_day + 7.days
  end

  def self.beginning_of_three_hour
    Time.now - 3.hours
  end
end
