# File theater_in_chicago.rb
class ScraperDetails
  attr_accessor :date, :title_text, :event_link, :theater, :time,
                :date_css_class, :title_css_class, :body_css_class,
                :theater_link

  def initialize
    @date_css_class  = ".JeffRedHead"
    @title_css_class = "#{date_css_class} > .detailhead a"
    @body_css_class  = "#{date_css_class} > .detailbody"
  end

  def digest(result)
    result.css(date_css_class, title_css_class, body_css_class).each do
    |html_date, html_title, html_body|
      30.times{ print "+"}
      puts html_date
      puts html_title
      puts html_body
    end
    puts result.inspect.squish

  end

  def create_attribute(post, index)
    if index.eql?(0)
      @date = post.css(date_css_class).text.squish
    end
    if index.eql?(1)
      @title_text     = post.css(title_css_class).text
      @event_link     = post.css(title_css_class).attribute("href").value
      @theater, @time = theater_and_time(post.css(body_css_class))
    end
  end

  def theater_and_time(node)
    temp_array = []
    node.children.each do |elem|
      temp_array << elem.text if elem.text?
    end
    return temp_array[0].squish, temp_array[1].squish
  end

  def showtime
    DateTime.parse("#{date} #{time}")
  end
end

class TheaterInChicagoScraper
  attr_accessor :entry_point, :url, :consumer

  def initialize(scrape_consumer = nil)
    @consumer = scrape_consumer || ScraperDetails.new
    @url         = "http://www.theatreinchicago.com/"
    @entry_point = "tr td"
  end


  def scrape(url)
    doc = Nokogiri::HTML(open(url || query_url))
    if url.nil?
      # doc.css(entry_point).to_ary.in_groups_of(3).each do |event_array|
      #   process_document_group(event_array)
      # end
      result = doc.css(entry_point)
      consumer.digest(result)
    else
      doc
    end
  end


  def process_document_group(event_array)
    tmp_event = ScraperDetails.new
    event_array.each_with_index do |post, index|
      tmp_event.create_attribute(post, index)
    end
    compile_event_information(tmp_event)
  end

  def query_url(month=10, year=2014)
    url+"opening/CalendarMonthlyResponse.php?ran=6563&month=#{month}&year=#{year}"
  end

  def compile_event_information(event_details)
    event = Event.find_or_initialize_by(name: event_details.title_text)
    scrape_event_details(event, event_details)

    venue = Venue.find_or_initialize_by(name: event_details.theater)
    EventDate.find_or_initialize_by(event:     event,
                                    venue:     venue,
                                    date_time: event_details.showtime)
    event.event_url = event_details.event_link
  end

  def scrape_event_details(event, event_details)
    if event.new_record?
      doc                        = scrape(event_details.event_link)
      event_details.theater_link = doc.css('#theatreName a')
      .attribute('href')
      .value
      detail_body = doc.css('p.detailBody')
      dates_table = doc.css('table.daysTable > tr')
      event.description = detail_body[0].text.squish
      event.price = detail_body[2].text.remove('Price:').squish
      event.show_type = detail_body[3].text.remove('Show Type:').squish
      event.phone_number = detail_body[4].text.remove('Box Office:').squish
      event.running_time = detail_body[5].text.remove('Running Time:').squish

    end
  end
end

scraper = TheaterInChicagoScraper.new
scraper.scrape(nil)


