class Order < ActiveRecord::Base
  belongs_to :item
  belongs_to :region
  belongs_to :station

  validates_inclusion_of :type, in: ['buy', 'sell'], message: "%{value} is not a valid order type"
  validates_numericality_of :in_game_id, greater_than_or_equal_to: 0, only_integer: true
  validates_numericality_of :security, greater_than_or_equal_to: -1.0, less_than_or_equal_to: 1.0
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates_presence_of :item, :region, :station
end
