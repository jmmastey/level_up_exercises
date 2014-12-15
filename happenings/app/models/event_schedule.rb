class EventSchedule
  def initialize(start_date = Date.today, end_date = Date.today)
    @start_date = start_date
    @end_date = end_date
  end

  #"http://www.theatreinchicago.com/opening/CalendarMonthlyResponse.php?ran=0&month=#{monthpage}&year=2014"

  def get_schedule
    api_url = AppConfig.feeds.base_api_url + "month=#{month}&year=#{year}"
    raw_html = HTTParty.get(api_url)
    html_DOM = Nokogiri::HTML(raw_html)
  end
end
