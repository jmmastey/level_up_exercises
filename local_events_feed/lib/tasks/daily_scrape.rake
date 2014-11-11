require 'assets/theatre_in_chicago/scraper'

def scrape_for_new_events
  [0, 25, 50, 75, 100].each do |upcoming_days|
    scrape_for_new_events_in(upcoming_days)
  end
end

def scrape_for_new_events_in(upcoming)
  future = upcoming.days.from_now
  events = TheatreInChicago::Scraper.get_events(future)
  events.each { |event| event.save }
end

desc "Scrape for events from sources and add to DB"
task :daily_scrape => :environment do
  scrape_for_new_events
end
