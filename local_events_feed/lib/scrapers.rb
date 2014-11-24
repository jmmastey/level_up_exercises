require 'theatre_in_chicago/scraper'
require 'scrape_time_permission'

module Scrapers

  SCRAPERS = {
    theatre_in_chicago: TheatreInChicago::Scraper
  }

  UPCOMING_DAYS = [0, 25, 50, 75, 100]

  def self.scrape_for_new_events
    SCRAPERS.each_key do |source|
      scrape_for_new_events_from_source(source)
    end
  end

  private

  def self.scrape_for_new_events_from_source(source)
    return unless permission(source).granted?
    UPCOMING_DAYS.each do |upcoming_days|
      scrape_for_new_events_in(upcoming_days, source)
    end
  end

  def self.scrape_for_new_events_in(upcoming, source)
    return unless scraper = SCRAPERS[source]
    future = upcoming.days.from_now
    scraper.add_events(future)
  end

  def self.permission(source)
    ScrapeTimePermission.new(source)
  end
end
