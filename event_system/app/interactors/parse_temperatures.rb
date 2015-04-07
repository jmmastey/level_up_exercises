class ParseTemperatures

  def self.call
    if WeatherForecast.today.count <= 0
      @document ||= fetch_document
      scraping =  WebScraper.scrape_temperatures @document
      scraping.each do |day, hash_temp|
        self.save_scraped_data(day, hash_temp, WeatherForecast.new)
      end
    else
      weather_forecast = WeatherForecast.today.select('weather_day, high, low')
      scraping = {}
      weather_forecast.each do |rec|
        scraping[rec.weather_day] = {}
        scraping[rec.weather_day] = { "high" => rec.high, "low" => rec.low }
      end
    end
    scraping
  end

  def self.fetch_document
    #return Nokogiri::HTML(open(BASE_URL)) if !Rails.env.test?
    Nokogiri::HTML(File.open("temperatures.html", "r"))
  end

  private

  def self.save_scraped_data(day, scraped_data, wf)
    wf[:weather_day] = day
    wf.attributes.each do |attr, value|
      next unless scraped_data[attr]
      wf[attr.to_sym] = scraped_data[attr]
    end
    wf.save!
  end

end