module ForecastsHelper
  def periods_by_day(forecast)
    days_and_nights = forecast.periods.group_by do |period|
      period.name.index(/night/i).nil?
    end
    days_and_nights[true].zip(days_and_nights[false])
  end
end
