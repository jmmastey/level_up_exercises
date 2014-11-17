class ForecastEmailWorker
  include Sidekiq::Worker

  def perform
    User.all.each do |user|
      ForecastMailer.update_email(user).deliver
    end
  end
end
