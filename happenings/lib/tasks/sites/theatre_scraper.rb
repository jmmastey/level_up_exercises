# File theater_in_chicago.rb
# TODO: Extract details class functionality into proper encapsulation
# TODO: Remove Scraping logic out of parser and move to Scraper Class
# TODO: Recreate entire classes with rspec tests

require_relative "../../helpers"
require_relative "event_scraper"

class TheatreScraper < EventScraper
  attr_accessor :parsing_date_month

  def defaults
    super.merge(
        url:         "http://www.theatreinchicago.com/",
          query:       "opening/CalendarMonthlyResponse.php?",
          event_class: "tr td span.detailhead a")
  end

  def process_document(doc)
    event_listings = doc.css(event_search_class)
    event_listings.each do |event_link|
      link = event_link.attribute("href").value
      # logger.info(link)
      p link
      process_event(scrape(link), link)
    end
  end

  def process_event(event_data, link)
    theatre_data  = event_data.at_css('#theatreName a')
    venue         = find_or_create_venue(theatre_data, event_data)
    event_name  = event_data.at_css('#titleP').text.squish
    theatre_event = Event.find_or_initialize_by(name: event_name)
    if theatre_event.new_record?
      theatre_event.venue       = venue
      theatre_event.event_url   = link
      theatre_event.description = event_data.at_css('p.detailBody').text.squish
      process_event_details(event_data.css('p.detailBody'), theatre_event)
      theatre_event.save
    end
    if theatre_event.venue.nil?
      theatre_event.venue = venue
      theatre_event.save
    end
    process_event_dates(event_data.css("table.daysTable > tr"), theatre_event)
  end

  def find_or_create_venue(theatre_data, event_data)
    if theatre_data.present?
      process_venue(theatre_data.attribute("href").value)
    else
      t_info = event_data.at_css('#theatreName').text
      t_info = t_info.split("\n").map(&:squish)
      create_venue(name:        t_info[1],
                     description: t_info[2],
                     address:     t_info[2])
    end
  end

  def create_event_dates(data, theatre_event)
    case data
      when /^\w+(,)\s\w+\s+\d+(:)\s\w+(:)\d+\w+/
        date, time = data.split(",")[1].split(":", 2)
        time       = time.split("&")
        time.each do |stime|
          parsed_date = showtime(date, stime)

          create_event_date(parsed_date, theatre_event)
        end
        return true
      when /(:)/
        day, time = data.split(":", 2)

        day  = "#{day.remove(":").downcase.singularize}?".to_sym
        days = parsing_date_month.all_month.reject { |d| !d.send(day) }
        days.each do |date_event|
          parsed_date = showtime(date_event, time)
          create_event_date(parsed_date, theatre_event)
        end
        return true
      else
        false
    end
  end

  protected

  def url(args = {})
    args                = args.merge(query_args)
    month               = args.fetch(:month)
    year                = args.fetch(:year)
    @parsing_date_month = Date.parse("1/#{month}/#{year}")
    super
  end

  def query_args
    { month: 10, year: 2014, ran: 6563 }
  end

  private

  def process_venue(venue_url)
    venue_data = scrape(venue_url)
    venue_name = venue_data.css("tr td.detailhead").text.squish
    venue      = Venue.find_or_initialize_by(name: venue_name)
    if venue.new_record?
      venue_details = venue_data.css("td.detailbody")
      process_venue_details(venue_details, venue)
      address = address(venue_data.css("tr td.body p").text)
      process_venue_location(address, venue)
      logger.info(venue.errors) unless venue.valid?
      venue.save
    end
    venue
  end

  def process_event_dates(event_date_data, theatre_event)
    event_date_data.each do |date_data|
      data = date_data.text.squish
      unless data.blank? || data.nil?
        create_event_dates(data, theatre_event)
      end
    end
  end

  def process_event_details(details, theatre_event)
    details.each do |detail|
      detail = detail.text.squish
      unless detail.blank?
        if detail.include?("Price:")
          theatre_event.price        ||= detail.remove("Price:")
        end
        if detail.include?("Show Type:")
          theatre_event.show_type    ||= detail.remove("Show Type:")
        end
        if detail.include?("Box Office:")
          theatre_event.phone_number ||= detail.remove("Box Office:")
        end
        if detail.include?("Running Time:")
          theatre_event.running_time ||= detail.remove("Running Time:")
        end
      end
    end
    theatre_event
  end

  def process_venue_location(address, venue)
    venue.city    ||= address.city
    venue.zipcode ||= address.zipcode if address.zipcode =~ /\d{5,9}+/
    venue.address ||= address.street if address.street =~ /\d/
  end

  def process_venue_details(venue_details, venue)
    venue_details.each do |detail|
      detail             = detail.text.squish
      if detail.include?("Phone:")
        venue.phone_number ||= detail.remove("Phone:").squish
      end
      venue.venue_url    ||= find_venue_url(detail)
    end
    venue.description = venue_details[1].text.squish
    venue
  end
end
