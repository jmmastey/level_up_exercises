class Merchant < ActiveRecord::Base
  MAX_DAYS_TO_CACHE = AppConfig.locu.caching_time

  belongs_to :location, autosave: true
  has_many :menus

  validates_presence_of :name, :location

  default_scope -> { joins(:location) }

  scope :with_menus, -> { includes(menus: :menu_items) }

  def recently_updated?
    updated_at && updated_at > MAX_DAYS_TO_CACHE.days.ago
  end
end
