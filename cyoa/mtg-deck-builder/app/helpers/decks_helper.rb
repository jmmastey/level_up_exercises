module DecksHelper
  def cards_in_deck_with_id(deck, card_id)
    cards = deck.cards.find_by_id(card_id)
    cards ? cards : []
  end
end
