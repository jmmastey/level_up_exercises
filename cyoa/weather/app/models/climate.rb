require 'weather'
require 'climate_helper'
class Climate < ActiveRecord::Base

  def self.weekly_weather
    Weather.forecast.daily.data
  end

  def self.persist_weather
    days = ClimateHelper.day_array
    weekly_weather.first(7).each_with_index do |daily_weather, indx|
      Climate.create({ max_temp:                  daily_weather.temperatureMax,
                       min_temp:                  daily_weather.temperatureMin,
                       precipitation_probability: daily_weather.precipProbability,
                       precipitation_type:        daily_weather.precipType,
                       humidity:                  daily_weather.humidity,
                       summary:                   daily_weather.summary,
                       date:                      Date.today,
                       day:                       days[indx] })
    end
  end
end
