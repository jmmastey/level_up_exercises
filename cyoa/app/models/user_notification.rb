class UserNotification < ActiveRecord::Base
  belongs_to :user

  def notification_time_today
    notification_time.in_time_zone
  end

  def notification_time_today_end
    notification_time_today + 24.hours
  end
end
