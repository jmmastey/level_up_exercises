require 'assets/theatre_in_chicago/scraper'

class ScrapeController < ApplicationController

  def index
    scrape_for_new_events
    redirect_to events_path
  end

  private

  def scrape_for_new_events
    [0, 25, 50, 75, 100].each do |upcoming_days|
      scrape_for_new_events_in(upcoming_days)
    end
  end

  def scrape_for_new_events_in(upcoming)
    future = upcoming.days.from_now
    events = TheatreInChicago::Scraper.get_events(future)
    events.each(&:add_to_db)
  end
end
