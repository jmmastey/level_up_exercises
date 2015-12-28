class MenuItem < ActiveRecord::Base
  belongs_to :menu

  validates_presence_of :name, :menu

  validates_absence_of :menu_subgroup, if: (lambda do |item|
    item.menu_group.present?
  end)

  default_scope -> { includes(:menu) }
end
