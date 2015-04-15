require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

# Get the weather every day at midnight
scheduler.cron("0 00 * * * ") do
  persist_weather
end
