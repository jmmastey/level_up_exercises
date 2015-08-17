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
    cards = where_types(cards, params[:cardtypes]) if params[:cardtypes]
    cards
  end

  private

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
