require 'active_support/all'

class Forecast < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  belongs_to :forecast_type
  has_many :forecast_weather_types
  has_many :weather_types, through: :forecast_weather_types
  
  scope :daily, -> { joins(:forecast_type).merge(ForecastType.daily) }
  scope :three_hour, -> { joins(:forecast_type).merge(ForecastType.three_hour) }

  def self.daily_for_next_week
    daily_for_range(beginning_of_today, end_of_week)
  end

  def self.daily_for_range(st, et)
    joins(:forecast_type)
    .merge(ForecastType.daily)
    .where("start_time >= :start", { start: st })
    .where("end_time <= :end", { end: et })
    .order(:start_time)
  end

  def self.three_hour_for_next_week
    three_hour_for_range(beginning_of_three_hour, end_of_week)
  end

  def self.three_hour_for_range(st, et)
    select(:id,
           :start_time,
           :end_time,
           :maxt,
           :mint,
           :cloud_cover,
           :icon_link,
           "array_agg(wt.weather_type ORDER BY fwt.additive DESC, wt.weather_type ASC) AS weather_types_a",
           "array_agg(fwt.coverage ORDER BY fwt.additive DESC, wt.weather_type ASC) AS coverages",
           "array_agg(fwt.additive ORDER BY fwt.additive DESC, wt.weather_type ASC) AS additives",
           "array_agg(fwt.qualifier ORDER BY fwt.additive DESC, wt.weather_type ASC) AS qualifiers"
           )
    .joins(:forecast_type)
    .merge(ForecastType.three_hour)
    .joins("LEFT JOIN forecast_weather_types fwt ON fwt.forecast_id = forecasts.id")
    .joins("LEFT JOIN weather_types wt ON wt.id = fwt.weather_type_id")
    .where("start_time >= :start", { start: st })
    .where("end_time <= :end", { end: et })
    .group("forecasts.id",
           "forecasts.start_time",
           "forecasts.end_time",
           "forecasts.maxt",
           "forecasts.mint",
           "forecasts.cloud_cover",
           "forecasts.icon_link")
    .order(:start_time)
  end

  def weather_type_display
    return nil unless has_weather_type_display
    return nil unless self.weather_types_a.any?
    final, wt, c = [], nil, ""
    self.weather_types_a.each_with_index do |weather_type, index|
      if wt == weather_type
        final.pop
        c = "#{c} #{self.coverages[index]}"
        final << "#{c} #{wt}"
      else
        wt = weather_type
        c = self.coverages[index]
        final << "#{assign_additive(index)}#{c} #{wt}"
      end
    end
    final.join(", ")
  end

  def assign_additive(index)
    return "" if self.additives[index].nil?
    "#{self.additives[index]} "
  end

  def has_weather_type_display
    (self.attributes.keys & 
     ["weather_types_a","coverages", "additives", "qualifiers"])
    .count == 4
  end

  def has_weather_type_display_data?
    return false unless has_weather_type_display
    weather_types_a.any?
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
