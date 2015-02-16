class ForecastMailer < ApplicationMailer
  default from: "forecast@showmetheweather.com"
  add_template_helper(ForecastsHelper)

  def daily_email(forecast, user)
    @forecast = forecast
    @user = user
    mail(to: @user.email, subject: "Forecast for #{@forecast.zip_code}",
      template_path: "forecasts", template_name: "show")
  end
end
