require_relative '../../lib/assets/theatre_in_chicago_scraper'

events = TheatreInChicagoScraper.get_events(2014, 11)
events.each do |event|
  puts event
end
