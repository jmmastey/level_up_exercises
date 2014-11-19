class SendReminderEmailWorker
  include Sidekiq::Worker

  def perform
    users = User.where(send_reminder: true)
    users.each do |user|
      ForecastMailer.update_email(user).deliver_later
    end
  end
end
