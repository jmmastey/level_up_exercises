class Menu < ActiveRecord::Base
  belongs_to :merchant
  has_many :menu_items

  validates_presence_of :name, :merchant
end
