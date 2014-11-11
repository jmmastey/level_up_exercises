class ScrapeTime < ActiveRecord::Base
  validates :source, presence: true, uniqueness: true
  validates :last_scrape_at, presence: true
  validates :inter_scrape_delay, presence: true

  after_initialize :set_defaults

  def set_defaults
    self.inter_scrape_delay ||= Time.at(1.day)
    self.last_scrape_at ||= inter_scrape_delay.to_i.seconds.ago
  end

  def permission_to_scrape?(current_time = nil)
    current_time ||= Time.now
    return false unless sufficient_time_has_passed(current_time)
    self.last_scrape_at = current_time
    self.save
    true
  end

  private

  def sufficient_time_has_passed(time)
    time.ago(self.inter_scrape_delay.to_i) >= self.last_scrape_at
  end
end
