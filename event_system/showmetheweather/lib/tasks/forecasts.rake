namespace :forecasts do
  desc "Update all forecasts"
  task update: :environment do
    User.all.each do |user|
      forecast = Forecast.recent(user.zip_code).last ||
        Forecast.retrieve(user.zip_code)
    end
  end

  desc "Mail forecasts to all users"
  task mail: [:environment, :update] do
    User.all.each do |user|
      forecast = Forecast.recent(user.zip_code).last
      ForecastMailer.daily_email(forecast, user).deliver_later
    end
  end
end
