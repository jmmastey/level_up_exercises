class Climate < ActiveRecord::Base

  def weekly_weather
    Weather.forecast.data
  end

  def persist_weather
    weekly_weather.first(7).each_with_index do |daily_weather, indx|
      Climate.create({ max_temp:                  daily_weather.temperatureMax,
                       min_temp:                  daily_weather.temperatureMin,
                       precipitation_probability: daily_weather.precipProbability,
                       precipitation_type:        daily_weather.precip_type,
                       humidity:                  daily_weather.humidity,
                       summary:                   daily_weather.summary,
                       date:                      Time.now,
                       day:                       Date::DAYNAMES[indx] })
    end
  end
end
