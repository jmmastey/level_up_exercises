class CardsMtgSet < ActiveRecord::Base
  belongs_to :card
  belongs_to :mtg_set
  validates_uniqueness_of :mtg_set, scope: :card_id
end
