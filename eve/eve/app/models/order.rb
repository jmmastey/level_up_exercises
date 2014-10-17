class Order < ActiveRecord::Base
  belongs_to :item
  belongs_to :region
  belongs_to :station

  validates_presence_of :in_game_id, :security, :price, :type
  validates_numericality_of :security, greater_than_or_equal_to: -1.0, less_than_or_equal_to: 1.0
  validates_numericality_of :price, greater_than_or_equal_to: 0
end
