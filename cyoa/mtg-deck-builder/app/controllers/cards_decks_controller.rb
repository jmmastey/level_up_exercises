class CardsDecksController < ApplicationController
  # add_card_to_deck
  def create
    deck_id = params[:deck_id]
    card_id = params[:card_id]
    @cards_deck = CardsDeck.find_or_create_by(deck_id: deck_id, card_id: card_id)
    @cards_deck.update_attributes(number_in_deck: @cards_deck.number_in_deck + 1)
  end

  # remove_card_from_deck
  def destroy
    deck_id = params[:deck_id]
    card_id = params[:card_id]
    @cards_deck = CardsDeck.where(deck_id: deck_id, card_id: card_id).first
    return head :ok if @cards_deck.number_in_deck == 0
    @cards_deck.update_attributes(number_in_deck: @cards_deck.number_in_deck - 1)
  end
end
