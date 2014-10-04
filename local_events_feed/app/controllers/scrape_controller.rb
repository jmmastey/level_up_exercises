require 'assets/theatre_in_chicago_scraper'

class ScrapeController < ApplicationController
  SECS_IN_DAY = 24 * 3600

  def index
    scrape_for_new_events
    redirect_to events_path
  end

  private

  def scrape_for_new_events
    (1..1).each do |upcoming_days|
      scrape_for_new_events_in(upcoming_days)
    end
  end

  def scrape_for_new_events_in(upcoming_days)
    future = (Time.now + SECS_IN_DAY * upcoming_days).to_date
    @raw_events = TheatreInChicagoScraper.get_events(future.year, future.month)
    add(@raw_events)
  end

  def add(raw_events)
    raw_events.each do |raw_event|
      event = convert_to_model(raw_event)
      event.save if unique?(event)
    end
  end

  def convert_to_model(raw_event)
    event = Event.new
    event.name = raw_event.name
    event.location = raw_event.location
    event.time = raw_event.time
    event
  end

  def unique?(event)
    !Event.all.any? { |other| other.match?(event) }
  end
end
