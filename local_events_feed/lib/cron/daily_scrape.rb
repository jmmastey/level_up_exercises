require 'assets/theatre_in_chicago_scraper'

def scrape_for_new_events
  (1..30).each do |upcoming_days|
    scrape_for_new_events_in(upcoming_days)
  end
end

def scrape_for_new_events_in(upcoming)
  future = upcoming.days.from_now
  @raw_events = TheatreInChicagoScraper.get_events(future.year, future.month)
  add(@raw_events)
end

def add(raw_events)
  raw_events.each do |raw_event|
    event = raw_event.to_event_model
    event.save if event.unique?
  end
end

scrape_for_new_events
