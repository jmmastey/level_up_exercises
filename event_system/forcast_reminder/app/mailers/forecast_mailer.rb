class ForecastMailer < ActionMailer::Base
  default from: "from@example.com"

  def update_email(user)
    @user = user
    @current_weather = CurrentWeather.find_by_station_id(user.station_id)
    @hourly_forecast = HourlyForecast.order(:time)
      .where("time > ?", Time.now)
      .where(zip_code: user.zip_code).all

    mail(to: @user.email, subject: "Daily Forecast Update")
  end
end
