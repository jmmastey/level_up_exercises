# File event_scraper.rb
require_relative "html_scraper"
require "open-uri"

class EventScraper
  include Helpers
  attr_accessor :event_search_class

  def initialize(args = {})
    args = args.merge(defaults)
    @url                   =  args.fetch(:url)
    @event_search_class = args.fetch(:event_class)
    @query = args.fetch(:query)
    scrape if args.fetch(:auto)
  end

  def defaults
    { auto: true }
  end

  def scrape(scrape_url = nil)
    doc = HTMLScraper.scrape(scrape_url || url)
    process_document(doc) if scrape_url.nil?
    doc
  end

  def process_document(_doc)
    raise NotImplementedError
  end

  def process_event(_event_data, _link)
    raise NotImplementedError
  end

  def create_venue(args)
    name = args.fetch(:name)
    description = args.fetch(:description)
    addy = args.fetch(:address)
    Venue.find_or_create_by(name:        name,
                            description: description,
                            address:     addy)
  end

  def create_event_date(parsed_date, event)
    EventDate.find_or_create_by(date_time: parsed_date,
                                event:     event,
                                venue:     event.venue)
  end

  protected

  def url(_args = {})
    "#{@url}#{@query}#{query_args.to_param}"
  end

  def query_args
    {}
  end
end
