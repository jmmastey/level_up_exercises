class Venue < ActiveRecord::Base
  has_many :venue_events
  has_many :events, through: :venue_events, inverse_of: :venue

  scope :index, -> { includes(:venue_events).all.limit(20) }

  validates :name, presence: true
  validates :description, presence: true, allow_blank: true
  validates :address, presence: true, allow_blank: true
  validates :city, presence: true, allow_blank: true
  validates :zipcode, presence: true, allow_blank: true
  validates :venue_url, presence: true, allow_blank: true, url: true
  validates :phone_number, presence: true, allow_blank: true

  validates_absence_of(:venue_events)
end
