class TheatreInChicagoEvents
  def initialize(opts = {})
    @start_date = opts[:start_date]
    @end_date   = opts[:end_date]
    @month      = opts[:month]
    @year       = opts[:year]
  end

  def self.get_events_between_dates(start_date, end_date)
    raise ArgumentError, "end date is before start date!" if start_date > end_date
    events = []
    (start_date.year..end_date.year).each_with_object(events) do |year, arr|
      if start_date.year == end_date.year
        arr << self.get_events_for_partial_year(start_date, end_date)
      elsif year <= start_date.year
        arr << self.get_events_for_partial_year(start_date, Date.parse("#{start_date.year}-12-31"))
      elsif year >= end_date.year
        arr << self.get_events_for_partial_year(Date.parse("#{end_date.year}-1-1"), end_date)
      else
        arr << self.get_events_for_year(year)
      end
    end
    events.flatten
  end

  def self.get_events_for_year(year)
    (1..12).each_with_object([]) { |month, arr| arr << get_events_for_month(month, year) }.flatten
  end

  def self.get_events_for_month(month, year)
    new({ month: month, year: year }).get_events_for_month
  end

  # Returns all events in a month
  # "http://www.theatreinchicago.com/opening/CalendarMonthlyResponse.php?ran=0&month=1&year=2014"

  # Returns all events on a day
  # "http://www.theatreinchicago.com/opening/CalendarSampleResponse.php?id=&ran=0&opendate=2014-12-12"

  def get_events_for_month
    raise ArgumentError, "invalid month value: #{@month}" unless @month.in?(1..12)
    raise ArgumentError, "invalid year value: #{@year}" unless @year.in?(1990..2020)

    api_url = AppConfig.feeds.base_api_url + "month=#{@month}&year=#{@year}"
    raw_html = HTTParty.get(api_url)
    parsed_html = Nokogiri::HTML(raw_html)

    event_dates  = parsed_html.css(".JeffRedHead")    # JeffReadHead, WTF?
    event_titles = parsed_html.css(".detailhead a")
    event_bodies = parsed_html.css(".detailbody")

    raw_events = []

    (0..event_titles.count - 1).each do |i|
      event_body = event_bodies[i].text.split.join(" ")
      time_regex = /\d{1,2}:\d{2}(am|pm)/

      event_description = event_body.gsub(time_regex, "").strip
      event_time        = event_body[time_regex]
      event_date        = Date.parse(event_dates[i].text)
      event_title       = event_titles[i].text
      event_url         = event_titles[i]["href"]

      raw_events << { description:    event_description,
                      title:          event_title,
                      url:            event_url,
                      time:           event_time,
                      date:           event_date,
                      event_source:   :theatre_in_chicago }
    end
    raw_events
  end

  private

  def self.get_events_for_partial_year(start_date, end_date)
    raise ArgumentError, "date range spans multiple years!" if start_date.year != end_date.year
    events = []
    (start_date.month..end_date.month).each do |month|
      if month <= start_date.month
        events << self.get_events_for_partial_month(month, start_date, end_date)
      elsif month >= end_date.month
        events << self.get_events_for_partial_month(month, start_date, end_date)
      else
        events << self.get_events_for_month(month, start_date.year)
      end
    end
    return events.flatten
  end

  def self.get_events_for_partial_month(month, start_date, end_date)
    raise ArgumentError, "date range spans multiple years!" if start_date.year != end_date.year
    events = self.get_events_for_month(month, start_date.year)
    events.select { |event| event[:date] >= start_date && event[:date] <= end_date }
  end
end
