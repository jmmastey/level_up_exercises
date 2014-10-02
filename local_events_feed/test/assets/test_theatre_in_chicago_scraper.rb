require_relative '../../lib/assets/theatre_in_chicago_scraper'

if ARGV.count == 2
  year  = ARGV[0].to_i
  month = ARGV[1].to_i
else
  year = 2014
  month = 11
end

events = TheatreInChicagoScraper.get_events(year, month)
events.each { |event| puts event }
