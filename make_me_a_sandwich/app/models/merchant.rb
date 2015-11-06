class Merchant < ActiveRecord::Base
  belongs_to :location
  has_many :menus

  validates_presence_of :name, :location, :phone, :description

  default_scope -> { joins(:location) }

  scope :with_menus, -> { includes(menus: :menu_items) }

  scope :in_city_state, (lambda do |city, state|
    where("locations.city = ? AND locations.state = ?", city, state)
  end)

  scope :in_zip, (lambda do |zip|
    keyword = zip + "-%"
    where("locations.zip = ? OR locations.zip LIKE ?", zip, keyword)
  end)
end
