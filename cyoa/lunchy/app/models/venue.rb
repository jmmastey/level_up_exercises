class Venue < ActiveRecord::Base
  validates :venue_id, uniqueness: true
end
