class DeckBrew
  include HTTParty
  BASE_URI = "http://api.deckbrew.com/mtg"

  def all_cards
    page = 0
    cards = []
    no_more_cards = false
    until no_more_cards do
      puts "On page #{page}"
      response = self.class.get("#{BASE_URI}/cards?page=#{page}")
      cards += response
      page += 1
      no_more_cards = true unless response.length > 0
    end
    cards
  end

  def load_cards(response)
    response.each do |card_data|
      card = load_card(card_data)
    end
    response.length
  end

  def load_card(card_data)
    Card.create(
      name:       card_data["name"],
      cost:       card_data["cost"],
      cmc:        card_data["cmc"],
      colors:     card_data["colors"],
      types:      card_data["types"],
      supertypes: card_data["supertypes"],
      subtypes:   card_data["subtypes"],
      text:       card_data["text"],
      power:      card_data["power"],
      toughness:  card_data["toughness"],
      image_url:  card_data["editions"].last["image_url"])
  end
end
