class Venue < ActiveRecord::Base
  has_many :history
  has_many :blacklist
  validates :venue_id, uniqueness: true
  validates :rating, presence: true
end
