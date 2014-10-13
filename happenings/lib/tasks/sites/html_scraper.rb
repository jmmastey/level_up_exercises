class HTMLScraper
  def self.scrape(url)
    Nokogiri::HTML(open(url))
  end
end
