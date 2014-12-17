class TheaterInChicagoEvents
  def initialize(start_date = Date.today, end_date = Date.today)
    @start_date = start_date
    @end_date = end_date
  end

  # Returns all events in a month
  # "http://www.theatreinchicago.com/opening/CalendarMonthlyResponse.php?ran=0&month=1&year=2014"

  # The following returns all events on a day
  # "http://www.theatreinchicago.com/opening/CalendarSampleResponse.php?id=&ran=0&opendate=2014-12-12"

  def self.get_events_for_month(month, year = Date.today.year)
    raise ArgumentError, "invalid month value: #{month}" unless valid_month(month)
    raise ArgumentError, "invalid year value: #{year}" unless valid_year(year)

    api_url = AppConfig.feeds.base_api_url + "month=#{month}&year=#{year}"
    raw_html = HTTParty.get(api_url)
    parsed_html = Nokogiri::HTML(raw_html)

    event_dates  = parsed_html.css(".JeffRedHead")    # JeffReadHead, WTF?
    event_titles = parsed_html.css(".detailhead a")
    event_bodies = parsed_html.css(".detailbody")

    raw_events = []

    (0..event_titles.count-1).each do |i|
      event_body = event_bodies[i].text.split.join(" ")
      time_regex = /\d{1,2}:\d{2}(am|pm)/

      event_description = event_body.gsub(time_regex, "").strip
      event_time        = event_body[time_regex]
      event_date        = Date.parse(event_dates[i].text)
      event_title       = event_titles[i].text
      event_url         = event_titles[i]["href"]

      raw_events << { description: event_description,
                      title:       event_title,
                      url:         event_url,
                      time:        event_time,
                      date:        event_date,
                      source:      :theater_in_chicago }
    end
    raw_events
  end

  private

  def valid_month(month)
    month.is_a?(Integer) && month > 0 && month < 13
  end

  def valid_year(year)
    year.is_a?(Integer) && year > 1900 && year < 2020
  end
end
