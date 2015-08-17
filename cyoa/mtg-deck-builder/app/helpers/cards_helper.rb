module CardsHelper
  SYMBOL_TO_CLASS = {
    "W" => 'ms-w',
    "B" => 'ms-b',
    "U" => 'ms-u',
    "G" => 'ms-g',
    "R" => 'ms-r',
    "W/U" => 'ms-wu',
    "W/B" => 'ms-wb',
    "U/B" => 'ms-ub',
    "B/R" => 'ms-br',
    "B/G" => 'ms-bg',
    "R/G" => 'ms-rg',
    "R/W" => 'ms-rw',
    "G/W" => 'ms-gw',
    "G/U" => 'ms-gu',
    "2/W" => 'ms-2w',
    "2/U" => 'ms-2u',
    "2/B" => 'ms-2b',
    "2/R" => 'ms-2r',
    "2/G" => 'ms-2g',
    "W/P" => 'ms-wp',
    "U/P" => 'ms-up',
    "B/P" => 'ms-bp',
    "R/P" => 'ms-rp',
    "G/P" => 'ms-gp',
    "S" => 'ms-s',
    "X" => 'ms-x',
  }

  def symbol_to_class(symbol)
    return unless symbol
    color_class = SYMBOL_TO_CLASS[symbol] if SYMBOL_TO_CLASS.key?(symbol)
    number_class = "ms-#{symbol}" unless color_class
    classes = "\"ms ms-cost ms-shadow #{color_class} #{number_class}\""
  end

  def mana_cost_to_html(cost_string)
    return unless cost_string
    symbols = cost_string.scan(/\{([A-Z1-9\/]+)\}/).flatten.map do |symbol|
      "<i class=#{symbol_to_class(symbol)}></i>"
    end
    symbols.join.html_safe
  end

  def types_to_html(card_types)
    return unless card_types
    card_types.map(&:name).join(', ')
  end
end
