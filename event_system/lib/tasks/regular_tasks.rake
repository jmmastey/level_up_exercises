
namespace :regular_tasks do
  desc "Sends email to alert weather conditions"
  task cron: :environment do

    @forecast_description = forecast_now

    @todays_forecast = WEATHER_WEAR.keys.select do |word|
      @forecast_description.match(word)
    end.first.capitalize

    @user = EmailContact.where(region_id: region_id)
    WeatherAlert.weather_alert(@user, @todays_forecast).deliver
  end

  def region_id
    @region_id ||= Region.where(city: "Chicago").pluck(:region_id).first
  end

  def forecast_now
    require 'parse_details'
    date, forecast = ParseDetails.call.first
    forecast.values.find { |x| !x.nil? }
  end
end
