module DecksHelper
  def cards_in_deck_with_id(deck, card_id)
    card = deck.cards.find_by_id(card_id)
    card ? cards : []
  end

  def find_number_of_card_in_deck(deck_id, card_id)
    cards_deck = find_cards_deck(deck_id, card_id)
    return cards_deck ? cards_deck.number_in_deck : 0
  end

  def find_cards_deck(deck_id, card_id)
    CardsDeck.where(deck_id: deck_id).where(card_id: card_id)[0]
  end
end
