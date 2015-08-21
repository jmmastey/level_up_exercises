require 'rails_helper'

describe Deck do
  it "has a valid factory" do
    expect(create(:deck)).to be_valid
  end

  it "is invalid without a user" do
    expect(build(:deck, user: nil)).to_not be_valid
  end

  it "is invalid without a name" do
    expect(build(:deck, name: nil)).to_not be_valid
  end

  context "cards exist" do
    before :each do
      @deck = create(:deck)
      @cards = Array.new(50) { create(:card) }
    end

    it "can contain a card" do
      card = @cards.sample
      create(:cards_deck, deck: @deck, card: card)
      expect(@deck.cards).to include(card)
    end

    it "can contain multiple cards" do
      cards = @cards.sample(rand(0..50))
      cards.each do |card|
        create(:cards_deck, deck: @deck, card: card)
      end
      cards.each do |card|
        expect(@deck.cards).to include(card)
      end
    end
  end
end
