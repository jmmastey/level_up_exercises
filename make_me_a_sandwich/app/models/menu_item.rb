class MenuItem < ActiveRecord::Base
  belongs_to :menu

  validates_presence_of :name, :menu
  validates_absence_of :subgroup, if: -> (item) { item.group.present? }

  default_scope -> { includes(:menu) }
end
