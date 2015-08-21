class Card < ActiveRecord::Base
  has_and_belongs_to_many :decks
  has_and_belongs_to_many :types
  validates :name, presence: true,
                   uniqueness: true
  serialize :colors
  serialize :supertypes
  serialize :subtypes

  def self.search(params)
    cards = where(nil)
    cards = where('name LIKE ?', "%#{params[:cardname]}%") if params[:cardname]
    cards = where_colors(cards, params[:cardcolors]) if params[:cardcolors]
    cards = where_colors_exclude(cards, params[:cardcolors]) if params[:exclude]
    cards = where_colors_multicolor(cards) if params[:multicolor]
    cards = where_colors_hybrid(cards) if params[:hybrid]
    cards = where_colors_pherexian(cards) if params[:pherexian]
    cards = where_mana_gt(cards, params[:minmana]) if params[:minmana]
    cards = where_mana_lt(cards, params[:maxmana]) if params[:maxmana]
    cards = where_text(cards, params[:cardtext]) if params[:cardtext]
    cards = where_types(cards, params[:cardtypes]) if params[:cardtypes]
    cards
  end

  def self.where_mana_gt(cards, min)
    cards.where('cmc >= ?', Integer(min))
  end

  def self.where_mana_lt(cards, max)
    cards.where('cmc <= ?', Integer(max))
  end

  def self.where_colors_pherexian(cards)
    cards.where('cost LIKE ?', "%P%")
  end

  def self.where_colors_exclude(cards, colors)
    colors_to_exclude = %w(black blue green red white) - colors
    colors_to_exclude.each do |color|
      cards = cards.where('colors NOT LIKE ?', "%#{color}%")
    end
    cards
  end

  def self.where_colors_multicolor(cards)
    cards.where('colors LIKE ?', "%- %- %")
  end

  def self.where_colors_hybrid(cards)
    cards.where('cost LIKE ?', "%/%")
  end

  def self.where_colors(cards, colors)
    colors.each do |color|
      cards = cards.where('colors LIKE ?', "%#{color}%")
    end
    cards
  end

  def self.where_text(cards, keywords)
    keywords.each do |keyword|
      cards = cards.where('text LIKE ?', "%#{keyword}%")
    end
    cards
  end

  def self.where_types(cards, types)
    types_group  = "GROUP_CONCAT(types.name)"
    having_types = "HAVING #{types_group} LIKE '%#{types.pop}%' "
    types.each do |type|
      having_types << "AND #{types_group} LIKE '%#{type}%' "
    end
    query = "
      SELECT cards.id FROM cards
      INNER JOIN cards_types ON cards.id = cards_types.card_id
      INNER JOIN types ON types.id = cards_types.type_id
      GROUP BY cards.name #{having_types}"
    cards.where(id: connection.execute(query).map { |result| result["id"] })
  end
end
