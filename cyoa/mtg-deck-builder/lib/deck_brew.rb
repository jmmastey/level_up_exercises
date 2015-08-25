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

  def all(something)
    puts "Getting all #{something} from DeckBrew"
    return all_cards if something == "cards"
    self.class.get("#{BASE_URI}/#{something}")
  end

  def all_cards
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

  def load_new_cards
    set_ids = all("sets").parsed_response.map { |set_data| set_data["id"] }
    all("sets").parsed_response.each do |set_data|
      next unless MtgSet.where(set_id: set_data["id"]).empty?
      load_set(set_data)
      load_cards_from_set(set_data["id"])
    end
  end

  def load_cards_from_set(set_id)
    cards = self.class.get("#{BASE_URI}/cards?set=#{set_id}")
    load_cards(cards)
  end

  def load_all_cards
    load_cards(all("cards"))
  end

  def load_all_types
    puts "LOADING TYPES"
    all("types").parsed_response.each do |type_name|
      puts "\tLoading type: #{type_name}"
      load_type(type_name) if Type.where(name: type_name).empty?
    end
  end

  def load_all_sets
    puts "LOADING SETS"
    all("sets").parsed_response.each do |set_data|
      puts "\tLoading set: #{set_data['name']}"
      load_set(set_data)
    end
    puts "Number of sets in database: #{MtgSet.all.count}"
  end

  def load_cards(response)
    puts "LOADING CARDS"
    load_all_types if Type.all.count == 0
    load_all_sets if MtgSet.all.count == 0
    response.each do |card_data|
      puts "\tLoading card: #{card_data['name']}"
      load_card(card_data)
    end
    puts "Number of cards in database: #{Card.all.count}"
  end

  def load_card(card_data)
    return unless Card.where(name: card_data["name"]).empty?
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

    load_cards_sets(card_data, card.id)
    load_cards_types(card_data, card.id)
  end

  def load_type(type_name)
    Type.create(name: type_name)
  end

  def load_set(set_data)
    MtgSet.create(
      set_id: set_data["id"],
      name: set_data["name"],
      set_type: set_data["type"]
    )
  end

  def load_cards_sets(card_data, card_id)
    set_names = card_data["editions"].map { |edition| edition["set"] }
    set_names.each do |set_name|
      mtg_set = MtgSet.where(name: set_name).first
      unless mtg_set
        puts "BAD SET: #{set_name}"
        next
      end
      set_id = mtg_set.id
      CardsMtgSet.create(card_id: card_id, mtg_set_id: set_id)
    end
  end

  def load_cards_types(card_data, card_id)
    return unless card_data["types"]
    types = fix_weird_types(card_data["types"])
    types.each do |type|
      type_id = Type.where(name: type).first.id
      CardsType.create(card_id: card_id, type_id: type_id)
    end
  end

  def fix_weird_types(types)
    weird_type = types.join(' ')
    WEIRD_SET_MAP.key?(weird_type) ? WEIRD_SET_MAP[weird_type] : types
  end
end
