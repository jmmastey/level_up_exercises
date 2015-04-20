# Preview all emails at http://localhost:3000/rails/mailers/weather_mailer
class WeatherMailerPreview < ActionMailer::Preview

  def daily_weather
    WeatherMailer.mail_weather
  end

end
