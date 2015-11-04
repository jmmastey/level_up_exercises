class Merchant < ActiveRecord::Base
  belongs_to :location

  validates_presence_of :name, :location, :phone, :description

  scope :with_location, -> { joins(:location) }

  scope :in_city_state, (lambda do |city, state|
    with_location.where("locations.city = ? AND locations.state = ?", city, state)
  end)

  scope :in_zip, (lambda do |zip|
    keyword = zip + "-%"
    with_location.where("locations.zip = ? OR locations.zip LIKE ?", zip, keyword)
  end)
end
