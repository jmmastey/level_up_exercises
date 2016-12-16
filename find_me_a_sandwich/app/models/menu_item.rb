class MenuItem < ActiveRecord::Base
  belongs_to :menu
  has_many :favorites

  validates_presence_of :name, :menu

  validates_absence_of :menu_subgroup, if: (lambda do |item|
    item.menu_group.present?
  end)

  default_scope -> { includes(:menu) }

  scope :favorited, lambda { |item, user|
    joins(:favorites)
      .where("favorites.menu_item_id = ?", item.id)
      .where("user_id = ?", user.id)
  }
end
