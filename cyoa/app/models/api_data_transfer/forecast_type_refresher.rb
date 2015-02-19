require './app/models/forecast_type'

module ForecastTypeRefresher
  def self.refresh!(times)
    forecast_times = times_by_forecast_type(times)
    update_refresh_start_times(forecast_times)
    update_refresh_end_times(forecast_times)
  end

  private

  def self.times_by_forecast_type(times)
    times.each_with_object([]) do |(key, value), final|
      final << key
    end.group_by { |row| row[:forecast_type_id] }
  end

  def self.update_refresh_start_times(forecast_times)
    forecast_times.map do |key, value|
      value.min_by { |h| h[:start_time] }
    end.each do |forecast_refresh|
      forecast_type = ForecastType.find(forecast_refresh[:forecast_type_id])
      forecast_type.update(last_refresh_start_time: forecast_refresh[:start_time])
      forecast_type.save!
    end
  end

  def self.update_refresh_end_times(forecast_times)
    forecast_times.map do |key, value|
      value.max_by { |h| h[:end_time] }
    end.each do |forecast_refresh|
      forecast_type = ForecastType.find(forecast_refresh[:forecast_type_id])
      forecast_type.update(last_refresh_end_time: forecast_refresh[:end_time])
      forecast_type.save!
    end
  end
end