class DeckBrew
  include HTTParty
  BASE_URI = "http://api.deckbrew.com/mtg"
  WEIRD_SET_MAP = {
    "eaturecray" => ["creature"],
    "enchant creature" => ["enchantment"],
    "creature enchant" => ["enchantment"],
    "enchant player" => ["enchantment"],
    "player enchant" => ["enchantment"],
    "interrupt" => ["instant"],
  }

  def all_cards
    puts "Getting all cards"
    page = 0
    cards = []
    loop do
      puts "\tOn page #{page}"
      response = self.class.get("#{BASE_URI}/cards?page=#{page}")
      page += 1
      cards += response
      break unless response.length > 0
    end
    cards
  end

  def all(something)
    return all_cards if something == "cards"
    self.class.get("#{BASE_URI}/#{something}")
  end

  def load_all_cards
    load_cards(all("cards"))
  end

  def load_all_types
    all("types").parsed_response.each do |type|
      puts type
      Type.create(name: type)
    end
  end

  def load_cards(response)
    load_all_types if Type.all.count == 0
    response.each do |card_data|
      load_card(card_data)
    end
    puts "Number of cards loaded: #{Card.all.count}"
  end

  def load_card(card_data)
    card = Card.create(
      name:       card_data["name"],
      cost:       card_data["cost"],
      cmc:        card_data["cmc"],
      colors:     card_data["colors"],
      supertypes: card_data["supertypes"],
      subtypes:   card_data["subtypes"],
      text:       card_data["text"],
      power:      card_data["power"],
      toughness:  card_data["toughness"],
      rarity:     card_data["editions"].last["rarity"],
      image_url:  card_data["editions"].last["image_url"])

    return unless card_data["types"]
    types = fix_weird_types(card_data["types"])
    types.each do |type|
      type_id = Type.where(name: type).first.id
      CardsType.create(card_id: card.id, type_id: type_id)
    end
  end

  def fix_weird_types(types)
    weird_type = types.join(' ')
    puts types, weird_type
    WEIRD_SET_MAP.key?(weird_type) ? WEIRD_SET_MAP[weird_type] : types
  end
end
