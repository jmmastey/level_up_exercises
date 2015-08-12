class CardsDecks < ActiveRecord::Base
  validates_uniqueness_of :card_id, :scope => :deck_id
end
