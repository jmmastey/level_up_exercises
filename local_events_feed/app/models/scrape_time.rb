class ScrapeTime < ActiveRecord::Base
  validates :source, presence: true, uniqueness: true
  validates :last_scrape_at, presence: true
  validates :inter_scrape_delay, presence: true

  after_initialize :set_defaults

  def set_defaults
    self.inter_scrape_delay ||= 86400
    self.last_scrape_at ||= Time.at(0)
  end
end
