require 'scrapers'

class ScrapeController < ApplicationController
    def index
    Scrapers.scrape_for_new_events
    redirect_to events_path
  end
end
