module HTMLScraper
  attr_accessor :consumer

  def initialize(scrape_consumer = nil)
    @consumer = scrape_consumer || ScraperDetails.new
    scrape

  end

  protected

  def scrape(url=nil)
    doc = Nokogiri::HTML(open(url || consumer.url))
    if url.nil?
      # doc.css(entry_point).to_ary.in_groups_of(3).each do |event_array|
      #   process_document_group(event_array)
      # end

      consumer.digest(doc)
    else
      doc
    end
  end
end
