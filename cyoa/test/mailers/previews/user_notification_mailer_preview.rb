class UserNotificationMailerPreview < ActionMailer::Preview
  def user_notification
    UserNotificationMailer.user_notification_email(UserNotification.first)
  end
end