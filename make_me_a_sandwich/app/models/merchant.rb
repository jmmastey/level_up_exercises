class Merchant < ActiveRecord::Base
  belongs_to :location, autosave: true
  has_many :menus

  validates_presence_of :name, :location

  default_scope -> { joins(:location) }

  scope :with_menus, -> { includes(menus: :menu_items) }

  scope :in_zip, (lambda do |zip|
    keyword = zip + "-%"
    where("locations.zip = ? OR locations.zip LIKE ?", zip, keyword)
  end)
end
