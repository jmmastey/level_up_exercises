class CardsDecksController < ApplicationController
  include DecksHelper
  # Add card to deck
  def add_card_to_deck
    render_nothing unless params[:deck_id] && params[:card_id]
    cards_decks = find_cards_deck(params[:deck_id], params[:card_id])
    cards_deck = (cards_decks ?
                  CardsDeck.find_by_id(cards_decks.id) :
                  CardsDeck.create(deck_id: params[:deck_id], card_id: params[:card_id]))
    cards_deck.update_attributes(number_in_deck: cards_deck.number_in_deck + 1)
    render_nothing
  end

  # Remove card from deck
  def remove_card_from_deck
    render_nothing unless params[:deck_id] && params[:card_id]
    cards_decks = find_cards_deck(params[:deck_id], params[:card_id])
    return render_nothing unless cards_decks

    cards_deck = CardsDeck.find_by_id(cards_decks.id)
    if cards_deck.number_in_deck == 1
      CardsDeck.destroy(cards_decks.id)
      return render_nothing
    end
    cards_deck.update_attributes(number_in_deck: cards_deck.number_in_deck - 1)
    render_nothing
  end

  def render_nothing
    render nothing: true
  end
end
