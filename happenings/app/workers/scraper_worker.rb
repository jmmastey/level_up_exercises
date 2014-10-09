require 'open-uri'
require 'nokogiri'
require 'capybara/poltergeist'
require_relative 'scraper_helper.rb'

class ScraperWorker
  include Sidekiq::Worker
  def perform
    scraper_helper.open_website
    current_event_month = scraper_helper.find_current_event_month
    current_month = Time.now.strftime("%b %Y")
    if(current_month==current_event_month)
      puts "Not downloading any new events"
    else
      puts "Downloading new data"
      scraper_helper.display_all_events
      sleep(1)
      scraper_helper.write_to_file('tmp.html')
      scrape_and_save_events
    end
  end

  private
  def scrape_and_save_events
    event_time_array = []
    puts "hashifying events"
    f = File.open("tmp.xml")
    doc = Nokogiri::XML(f)
    f.close
    event_date_nodes = scraper_helper.all_date_nodes(doc)
    event_title_nodes = scraper_helper.all_title_nodes(doc)
    event_location_nodes = scraper_helper.all_location_nodes(doc)
    event_time_array = scraper_helper.listify_time_nodes(doc)

    #found zip and thought it was cool but now i dont know 
    ##how to refactor this
    event_time_array.reject(&:empty?).zip(event_title_nodes, event_location_nodes, event_date_nodes).each do|event_time, event_title_node, event_location_node, event_date_node|
      event_location = scraper_helper.make_pretty_string(event_location_node)
      event_title = scraper_helper.make_pretty_string(event_title_node.text)
      event_date = scraper_helper.make_pretty_string(event_date_node)
      Event.create(title: event_title, location: event_location, time: event_time, date: event_date
    end
  end
end
