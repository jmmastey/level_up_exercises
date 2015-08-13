class CardsDeck < ActiveRecord::Base
  belongs_to :deck
  belongs_to :card
  validates_uniqueness_of :card_id, :scope => :deck_id
end
