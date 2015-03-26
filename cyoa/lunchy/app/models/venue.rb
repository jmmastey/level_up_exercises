class Venue < ActiveRecord::Base
  validates :venue_id, uniqueness: true
  validates :rating, presence: true
end
