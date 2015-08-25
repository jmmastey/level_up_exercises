require 'rails_helper'

class DummyClass; end

describe DecksHelper do
  before :each do
    @dummy_helper = DummyClass.new.extend(DecksHelper)
  end

  context "deck has cards" do
    before :each do
      @deck = create(:deck)
      @cards = Array.new(50) { create(:card) }
      @cards.each do |card|
        create(:cards_deck, deck: @deck, card: card, number_in_deck: rand(0..4))
      end
    end

    it "can find number of cards in a deck" do
      card = create(:card)
      number_in_deck = rand(0..4)
      cards_deck = create(:cards_deck, deck: @deck, card: card, number_in_deck: number_in_deck)
      expect(@dummy_helper.find_number_of_card_in_deck(@deck.id, card.id)).to eq(number_in_deck)
    end

    it "can find cards-deck association" do
      card = @cards.sample
      cards_deck = @dummy_helper.find_cards_deck(@deck.id, card.id)
      expect(cards_deck.card_id).to eq(card.id)
      expect(cards_deck.deck_id).to eq(@deck.id)
    end

    it "can find cards in deck with number_in_deck > 0" do
      card = create(:card)
      cards_deck = create(:cards_deck, deck: @deck, card: card, number_in_deck: 0)
      expect(@dummy_helper.non_zero_cards_in_deck(@deck)).to_not include(card)
    end

    it "can sum number_in_deck for a subset of cards" do
      card_subset = Array.new(10) { create(:card) }
      total_number_of_cards_in_subset = 0
      card_subset.each do |card|
        n = rand(0..4)
        total_number_of_cards_in_subset += n
        create(:cards_deck, deck: @deck, card: card, number_in_deck: n)
      end
      result = @dummy_helper.total_number_of_card_subset_in_deck(@deck, card_subset)
      expect(result).to eq(total_number_of_cards_in_subset)
    end
  end
end
