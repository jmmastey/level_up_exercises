class OpeningNightPage
  attr_reader :website_url, :title_xpath, :date_xpath, :location_xpath, :time_xpath, :month_xpath
  def initialize
    @website_url = "http://www.theatreinchicago.com/opening/openingnight.php"
    @title_xpath = '//td[@id="calendar_details"]//span[@class = "detailhead"]'
    @date_xpath = '//td[@id="calendar_details"]//span[@class = "JeffRedHead"]'
    @location_xpath = '//td[@id="calendar_details"]//span[@class = "detailbody"]'
    @time_xpath = '//td[@id="calendar_details"]//span[@class = "detailbody"]/br'
    @month_xpath = "//div[@id='quickCalender']/table/tbody/tr/th[3]/a[@class='headerNav']"
  end
end