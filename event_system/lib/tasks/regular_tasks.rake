namespace :regular_tasks do
  desc "Sends email to alert weather conditions"
  task cron: :environment do

    @detail_forecasts = Class.new.extend(ParseWeather).parse_details

    forecast_now = Hash[*@detail_forecasts.values].values[0].downcase

    @todays_forecast = WEATHER_WEAR.keys.select do |word|
      forecast_now.match(word)
    end.first.capitalize

    @user = EmailContact.where(region_id: region_id)
    WeatherAlert.weather_alert(@user, @todays_forecast).deliver
  end

  def region_id
    @region_id ||= Region.where(city: "Chicago").pluck(:region_id).first
  end
end
