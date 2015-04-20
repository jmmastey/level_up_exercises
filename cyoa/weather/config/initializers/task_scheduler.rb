require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

# Get the weather every day at midnight
scheduler.cron("0 00 * * * ") do
  persist_weather
end

# Send weather updates to users
scheduler.cron("0 06 * * *") do
  WeatherMailer.mail_weather.deliver_now
end
