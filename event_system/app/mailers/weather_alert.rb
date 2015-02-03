class WeatherAlert < ActionMailer::Base
  default from: "from@example.com"

  def weather_alert(contact, weather)
    Rails.logger.info " BEFORE SENDING #{contact.inspect}"
    mail(to: contact.first.email, subject: 'Weather Alert')
  end
end
