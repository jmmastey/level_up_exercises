require 'rails_helper'

MAGIC_COLORS = %w(black blue green red white)

def generate_unique_card_name(names)
  name = Faker::Name.name
  names.include?(name) ? generate_unique_card_name(names) : name
end

def generate_non_magic_color
  color = Faker::Commerce.color
  MAGIC_COLORS.include?(color) ? generate_non_magic_color : color
end

def generate_non_existent_text_keyword
  keyword = Faker::Commerce.color
  all_card_text = @cards.map(&:text).join
  return generate_non_existent_text_keyword if all_card_text.include?(keyword)
  keyword
end

def generate_non_existent_cmc
  # If no non-existent cmcs can be found, use -1
  # (since a card can never have a negative cmc)
  non_existent_cmcs = ((1..20).to_a - @cards.map(&:cmc)).sample
  non_existent_cmcs ? non_existent_cmcs : -1
end

def generate_non_existent_type
  type = Faker::Lorem.word
  @types.map(&:name).include?(type) ? generate_non_existent_type : type
end

def excluded_colors(colors)
  MAGIC_COLORS - colors
end

def expect_search_results_to_include(params, card)
  results = Card.search(params)
  expect(results).to_not be_empty
  expect(results).to include(card)
  results
end

def expect_search_results_to_be_empty(params)
  expect(Card.search(params)).to be_empty
end

def give_cards_random_subset_of_types
  @cards.each do |card|
    rand(1..@n_types).times do
      type = @types.sample
      unless card.types.include?(type)
        create(:cards_type, card: card, type: type)
      end
    end
  end
end

describe Card do
  it "has a valid factory" do
    expect(create(:card)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:card, name: nil)).to_not be_valid
  end

  it "can have types associated with it" do
    card = create(:card)
    type = create(:type)
    create(:cards_type, card: card, type: type)
    expect(card.types).to include(type)
  end

  it "can have multiple types associated with it" do
    card = create(:card)
    types = Array.new(rand(1..5)) { create(:type) }
    types.each do |type|
      create(:cards_type, card: card, type: type)
    end
    types.each do |type|
      expect(card.types).to include(type)
    end
  end

  describe "filter cards by search parameters" do
    before :each do
      @n_types = 5
      @n_cards = 50
      @types = Array.new(@n_types) { create(:type) }
      @cards = Array.new(@n_cards) { create(:card) }
      give_cards_random_subset_of_types
    end

    context "matching cards exist" do
      it "returns cards searched by name" do
        card = @cards.sample
        params = {
          cardname: card.name,
        }
        expect_search_results_to_include(params, card)
      end

      it "returns cards searched by color" do
        card = @cards.sample
        params = {
          cardcolors: card.colors,
        }
        expect_search_results_to_include(params, card)
      end

      it "returns cards searched by color, excluding other colors" do
        card = @cards.sample
        params = {
          cardcolors: card.colors,
          exclude: true,
        }
        results = expect_search_results_to_include(params, card)
        result_colors = results.map(&:colors).flatten.uniq
        expect(result_colors).to_not contain_exactly(excluded_colors(result_colors))
      end

      it "returns cards searched only for multicolor" do
        params = {
          multicolor: true,
        }
        cards = Card.search(params)
        cards.each { |card| expect(card.colors.count).to be > 1 }
      end

      it "returns cards searched only for hybrid mana" do
        params = {
          hybrid: true,
        }
        cards = Card.search(params)
        cards.each { |card| expect(card.mana).to include('/') }
      end

      it "returns cards searched only for pherexian mana" do
        params = {
          pherexian: true,
        }
        cards = Card.search(params)
        cards.each { |card| expect(card.mana).to include('P') }
      end

      it "returns cards searched by for minimum converted mana cost" do
        min_cmc = rand(20)
        params = {
          minmana: min_cmc,
        }
        cards = Card.search(params)
        cards.each { |card| expect(card.cmc).to be >= min_cmc }
      end

      it "returns cards searched by for maximum converted mana cost" do
        max_cmc = rand(20)
        params = {
          maxmana: max_cmc,
        }
        cards = Card.search(params)
        cards.each { |card| expect(card.cmc).to be <= max_cmc }
      end

      it "returns cards searched by for exact converted mana cost" do
        cmc = rand(20)
        params = {
          minmana: cmc,
          maxmana: cmc,
        }
        cards = Card.search(params)
        cards.each { |card| expect(card.cmc).to eq(cmc) }
      end

      it "returns cards searched by card text keywords" do
        card = @cards.sample
        card_text_len = card.text.length
        keyword = card.text[rand(card_text_len), rand(card_text_len)]
        params = {
          cardtext: [keyword],
        }
        expect_search_results_to_include(params, card)
      end

      it "returns cards searched by card type" do
        card = @cards.sample
        params = {
          cardtypes: card.types.map(&:name),
        }
        expect_search_results_to_include(params, card)
      end
    end

    context "matching cards do not exist" do
      it "returns nothing searched by name" do
        params = {
          cardname: generate_unique_card_name(@cards.map(&:name)),
        }
        expect_search_results_to_be_empty(params)
      end

      it "returns nothing searched by color" do
        params = {
          cardcolors: [generate_non_magic_color],
        }
        expect_search_results_to_be_empty(params)
      end

      it "returns nothing searched by color, excluding other colors" do
        params = {
          cardcolors: [generate_non_magic_color],
          exclude: true,
        }
        expect_search_results_to_be_empty(params)
      end

      it "returns nothing searched only for multicolor" do
        params = {
          cardcolors: [generate_non_magic_color],
          multicolor: true,
        }
        expect_search_results_to_be_empty(params)
      end

      it "returns nothing searched only for hybrid mana" do
        params = {
          cardcolors: [generate_non_magic_color],
          hybrid: true,
        }
        expect_search_results_to_be_empty(params)
      end

      it "returns nothing searched only for pherexian mana" do
        params = {
          cardcolors: [generate_non_magic_color],
          pherexian: true,
        }
        expect_search_results_to_be_empty(params)
      end

      it "returns nothing searched by for minimum converted mana cost" do
        params = {
          minmana: @cards.map(&:cmc).max + 1,
        }
        expect_search_results_to_be_empty(params)
      end

      it "returns nothing searched by for maximum converted mana cost" do
        params = {
          maxmana: @cards.map(&:cmc).min - 1,
        }
        expect_search_results_to_be_empty(params)
      end

      it "returns nothing searched by for exact mana cost" do
        cmc = generate_non_existent_cmc
        params = {
          minmana: cmc,
          maxmana: cmc,
        }
        expect_search_results_to_be_empty(params)
      end

      it "returns nothing searched by card text keywords" do
        params = {
          cardtext: [generate_non_existent_text_keyword],
        }
        expect_search_results_to_be_empty(params)
      end

      it "returns nothing searched by card type" do
        params = {
          cardtypes: [generate_non_existent_type],
        }
        expect_search_results_to_be_empty(params)
      end
    end
  end
end
