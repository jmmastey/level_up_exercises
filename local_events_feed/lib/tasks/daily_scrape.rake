desc "Scrape for events from sources and add to DB"

task :daily_scrape => :environment do
  Scrapers.scrape_for_new_events
end
