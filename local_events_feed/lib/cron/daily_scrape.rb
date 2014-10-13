require 'assets/theatre_in_chicago_scraper'

SECS_IN_DAY = 24 * 60 * 60

def scrape_for_new_events
  (1..30).each do |upcoming_days|
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
    event = raw_event.to_event_model
    event.save if unique?(event)
  end
end

def unique?(event)
  !Event.all.any? { |other| other.same_as?(event) }
end


scrape_for_new_events
