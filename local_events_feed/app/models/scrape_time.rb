class ScrapeTime < ActiveRecord::Base
  validates :source, presence: true, uniqueness: true
end
