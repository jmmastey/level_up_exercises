class Watch < ActiveRecord::Base
  belongs_to :item
  belongs_to :user
  belongs_to :region
  belongs_to :station
  has_many :orders, through: :item

  validates_presence_of :item, :user
  validates_with LocationFilterValidator
end
