class ScrapeTimePermission
  def initialize(source, current_time = nil)
    @scrape_time = ScrapeTime.find_or_create_by(source: source.to_s)
    @now = current_time || Time.now
  end

  def granted?
    @scrape_time.with_lock do
      able_to_set_new_scrape_time?
    end
  end

  private
  
  def able_to_set_new_scrape_time?
    return false unless @now.ago(inter_scrape_delay) >= last_scrape_time
    @scrape_time.last_scrape_at = @now
    @scrape_time.save
  end

  def inter_scrape_delay
    @scrape_time.inter_scrape_delay.to_i
  end

  def id
    @scrape_time.id
  end

  def last_scrape_time
    @scrape_time.last_scrape_at
  end
end
