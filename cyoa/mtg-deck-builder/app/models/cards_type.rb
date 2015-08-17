class CardsType < ActiveRecord::Base
  belongs_to :card
  belongs_to :type
  validates_uniqueness_of :type_id, :scope => :card_id
end
