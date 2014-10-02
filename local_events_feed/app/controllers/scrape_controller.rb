#require_relative '../../lib/assets/theatre_in_chicago_scraper'

class ScrapeController < ApplicationController
  SECS_IN_DAY = 24 * 3600

  def index
    render plain: "<h2>Scraping, Please Wait...</h2>"
    scrape_for_new_events
  end

  private

  def scrape_for_new_events
    (1..1).each do |upcoming_days|
      scrape_for_new_events_in(upcoming_days)
    end
  end

  def scrape_for_new_events_in(upcoming_days)
    future = (Time.now + SECS_IN_DAY * upcoming_days).to_date
    #@raw_events = TheatreInChicagoScraper.get_events(future.year, future.month)
    @raw_events = TheatreInChicagoScraper.get_events(2014, 12)
  end
end
