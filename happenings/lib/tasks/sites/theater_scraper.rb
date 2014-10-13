# File theater_in_chicago.rb
# require_relative "../../html_scraper"
# TODO: Extract ScraperDetails Into Top Level Class
# TODO: HTMLParser needs to not be so tightly coupled with HTML Scraper
# TODO: Extract details class functionality into proper encapsulation
# TODO: Remove Scraping logic out of parser and move to Scraper Class
# TODO: Remove methods used for scraping incorrectly
# TODO: Remove circular logic and evaluation
# TODO: Cause details to be extracted per record
# TODO: Add checks for invalid server responses from sources
# TODO: Recreate entire classes with rspec tests
require_relative 'html_scraper'
require 'open-uri'
require_relative '../../helpers'


class TheaterScraper
  include Helpers
  attr_accessor :events_link_css_class, :parsing_date_month

  def initialize
    @url                   = "http://www.theatreinchicago.com/"
    @events_link_css_class = "tr td span.detailhead a"
    scrape
  end

  def scrape(scrape_url = nil)
    doc = HTMLScraper.scrape(scrape_url || url)
    process_document(doc) if scrape_url.nil?
    doc

  end

  def process_document(doc)
    event_listings = doc.css(events_link_css_class)
    event_listings.each do |event_link|
      link = event_link.attribute("href").value
      p link
      process_event(scrape(link), link)
    end
  end

  def process_event(event_data, link)
    # p event_data.at_css('#theatreName a').attribute("href").value
    theater_data  = event_data.at_css('#theatreName a')
    venue         = find_venue(theater_data, event_data)
    theater_name  = event_data.at_css('#titleP').text.squish
    theater_event = Event.find_or_initialize_by(name: theater_name)
    if theater_event.new_record?
      theater_event.venue       = venue
      theater_event.event_url = link
      theater_event.description = event_data.at_css('p.detailBody').text.squish
      process_event_details(event_data.css('p.detailBody'), theater_event)
      theater_event.save
    end
    if theater_event.venue.nil?
      theater_event.venue = venue
      theater_event.save
    end
    process_event_dates(event_data.css("table.daysTable > tr"), theater_event)
  end

  def find_venue(theater_data, event_data)
    if theater_data.present?
      process_venue(theater_data.attribute("href").value)
    else
      t_info = event_data.at_css('#theatreName').text
      t_info = t_info.split("\n").map { |e| e.squish }
      Venue.find_or_create_by(name:        t_info[1],
                              description: t_info[2],
                              address:     t_info[2])
    end
  end

  def process_event_dates(event_date_data, theater_event)
    event_date_data.each do |date_data|
      data = date_data.text.squish
      unless data.blank? || data.nil?
        create_event_dates(data, theater_event)
      end
    end
  end

  def create_event_dates(data, theater_event)
    case data
      when /^\w+(,)\s\w+\s+\d+(:)\s\w+(:)\d+\w+/
        date, time = data.split(",")[1].split(":", 2)
        time       = time.split("&")
        time.each do |stime|
          parsed_date = showtime(date, stime)

          create_event_date(parsed_date, theater_event)
        end
        return true
      when /(:)/
        day, time = data.split(":", 2)

        day  = "#{day.remove(":").downcase.singularize}?".to_sym
        days = parsing_date_month.all_month.reject { |d| !d.send(day) }
        days.each do |date|
          parsed_date = showtime(date, time)
          create_event_date(parsed_date, theater_event)
        end
        return true
      else
        false
    end
  end

  def create_event_date(parsed_date, theater_event)
    EventDate.find_or_create_by(date_time: parsed_date,
                                event:     theater_event,
                                venue:     theater_event.venue)
  end

  def process_event_details(details, theater_event)
    details.each do |detail|
      detail = detail.text.squish
      unless detail.blank?
        theater_event.price        ||= detail.remove("Price:") if detail.include?("Price:")
        theater_event.show_type    ||= detail.remove("Show Type:") if detail.include?("Show Type:")
        theater_event.phone_number ||= detail.remove("Box Office:") if detail.include?("Box Office:")
        theater_event.running_time ||= detail.remove("Running Time:") if detail.include?("Running Time:")
      end
    end
    theater_event
  end

  def process_venue_location(address, venue)

    venue.city    ||= address.city
    venue.zipcode ||= address.zipcode if address.zipcode =~ /\d{5,9}+/
    venue.address ||= address.street if address.street =~ /\d/
  end

  def process_venue(venue_url)
    venue_data = scrape(venue_url)
    venue_name = venue_data.css("tr td.detailhead").text.squish
    venue      = Venue.find_or_initialize_by(name: venue_name)
    if venue.new_record?
      venue_details = venue_data.css("td.detailbody")
      process_venue_details(venue_details, venue)
      address = address(venue_data.css("tr td.body p").text)

      process_venue_location(address, venue)
      unless venue.valid?
         p venue.errors
      end
      venue.save
    end
    venue

  end

  def process_venue_details(venue_details, venue)
    venue_details.each do |detail|
      detail             = detail.text.squish
      venue.phone_number ||= detail.remove("Phone:").squish if detail.include?("Phone:")
      venue.venue_url    ||= find_venue_url(detail)
    end
    venue.description = venue_details[1].text.squish
    venue
  end

  def find_venue_url(detail)
    case detail
      when /www./ && /http:/
        detail
      when /www./ && !/http:/
        "http://#{detail}"
      else
        nil
    end
  end


  def url(month=10, year=2014)
    @parsing_date_month = Date.parse("1/#{month}/#{year}")
    @url+"opening/CalendarMonthlyResponse.php?ran=6563&month=#{month}&year=#{year}"
  end

  def showtime(date, time)
    Time.zone = "US/Central"
    Time.zone.parse("#{date} #{time}").to_datetime
  end


end

TheaterScraper.new



