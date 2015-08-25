module CardsHelper
  TYPE_ORDERING = %w(
    creature
    enchantment
    instant
    sorcery
    land
    artifact
    planeswalker)

  SYMBOL_TO_CLASS = {
    "W" => 'ms-w',
    "B" => 'ms-b',
    "U" => 'ms-u',
    "G" => 'ms-g',
    "R" => 'ms-r',
    "W/U" => 'ms-wu ms-split',
    "W/B" => 'ms-wb ms-split',
    "U/B" => 'ms-ub ms-split',
    "U/R" => 'ms-ur ms-split',
    "B/R" => 'ms-br ms-split',
    "B/G" => 'ms-bg ms-split',
    "R/G" => 'ms-rg ms-split',
    "R/W" => 'ms-rw ms-split',
    "G/W" => 'ms-gw ms-split',
    "G/U" => 'ms-gu ms-split',
    "2/W" => 'ms-2w ms-split',
    "2/U" => 'ms-2u ms-split',
    "2/B" => 'ms-2b ms-split',
    "2/R" => 'ms-2r ms-split',
    "2/G" => 'ms-2g ms-split',
    "W/P" => 'ms-wp',
    "U/P" => 'ms-up',
    "B/P" => 'ms-bp',
    "R/P" => 'ms-rp',
    "G/P" => 'ms-gp',
    "S" => 'ms-s',
    "X" => 'ms-x',
    "T" => 'ms-tap',
    "Q" => 'ms-untap',
  }

  def symbol_to_class(symbol)
    return unless symbol
    color_class = SYMBOL_TO_CLASS[symbol] if SYMBOL_TO_CLASS.key?(symbol)
    number_class = "ms-#{symbol}" unless color_class
    "\"ms ms-cost ms-shadow #{color_class} #{number_class}\""
  end

  def mana_cost_to_html(cost_string)
    return unless cost_string
    symbols = cost_string.scan(%r(\{([A-Z0-9\/]+)\})).flatten.map do |symbol|
      "<i class=#{symbol_to_class(symbol)}></i>"
    end
    symbols.join.html_safe
  end

  def better_card_text(card_text)
    return unless card_text
    card_text.gsub(/\{[A-Z0-9]+\}/) { |cost_string| mana_cost_to_html(cost_string) }.html_safe
  end

  def types_to_html(card_types)
    return unless card_types
    card_types.map(&:name).join(', ')
  end

  def organize_cards_by_type(cards)
    groups = Hash.new { |h, k| h[k] = [] }
    TYPE_ORDERING.each do |type|
      groups[type] = cards.select { |card| card.types.map(&:name).include?(type) }
      groups[type].each { |card| cards -= [card] }
    end
    cards.each { |card| groups["other"] << card }
    groups
  end
end
