class Venue < ActiveRecord::Base
  has_many :venue_events
  has_many :events, through: :venue_events, inverse_of: :venue

  validates :name, presence: true
end
