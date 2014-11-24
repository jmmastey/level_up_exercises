require_relative '../../../lib/theatre_in_chicago_scraper'

if ARGV.count == 2
  year  = ARGV[0].to_i
  month = ARGV[1].to_i
else
  year = 2014
  month = 11
end

events = TheatreInChicago::Scraper.get_events(year, month)
events.each { |event| puts event }
