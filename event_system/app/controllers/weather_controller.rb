
class WeatherController < ApplicationController
  def index
    if params.has_key? "region"
      Rails.logger.info " PARAMS #{params["region"]["name"].inspect}"
      @scraping =  WebScraper.scrape
    end
  end

  def show

  end
end
