class WeatherAlert < ActionMailer::Base
  default from: "from@example.com"

  def weather_alert(contact, weather)
    Rails.logger.info " BEFORE SENDING #{contact.inspect}"
    @user = contact.first.email
    @weather_forecast = weather
    mail(to: @user, subject: 'Weather Alert')
  end
end
