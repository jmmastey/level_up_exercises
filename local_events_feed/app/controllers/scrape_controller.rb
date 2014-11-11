require 'assets/theatre_in_chicago/scraper'

class ScrapeController < ApplicationController
  
  #class Scraper

  SCRAPERS = {
    theatre_in_chicago: TheatreInChicago::Scraper
  }

  UPCOMING_DAYS = [0, 25, 50, 75, 100]

  def index
    scrape_for_new_events
    redirect_to events_path
  end

  private

  def scrape_for_new_events
    SCRAPERS.each_key do |source|
      scrape_for_new_events_from_source(source)
    end
  end

  def scrape_for_new_events_from_source(source)
    return unless scrape_time = get_scrape_time_for(source)
    return unless scrape_time.permission_to_scrape?
    UPCOMING_DAYS.each do |upcoming_days|
      scrape_for_new_events_in(upcoming_days, source)
    end
  end

  def scrape_for_new_events_in(upcoming, source)
    return unless scraper = SCRAPERS[source]
    future = upcoming.days.from_now
    events = scraper.get_events(future)
    events.each(&:add_to_db)
  end

  def get_scrape_time_for(source)
    ScrapeTime.find_or_create_by(source: source.to_s)
  end
end
