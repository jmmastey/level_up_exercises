class UserNotificationMailer < ApplicationMailer
  def user_notification_email(user_notification)
    @user = User.find(user_notification.user_id)
    @weather_url = home_index_path
    st = user_notification.notification_time_today
    et = user_notification.notification_time_today_end
    @forecast_daily = Forecast.daily_for_range(st, et)
    @forecast_three_hour = Forecast.three_hour_for_range(st, et)
    binding.pry
    mail(to: @user.email, subject: "What you need to wear today!")
  end
end
