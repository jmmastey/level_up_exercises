class Card < ActiveRecord::Base
  has_and_belongs_to_many :decks
  validates :name, presence: true,
                   uniqueness: true
  serialize :colors
  serialize :types
  serialize :supertypes
  serialize :subtypes

  def self.search_by_name(cardname)
    return all unless cardname
    where('name LIKE ?', "%#{cardname}%")
  end
end
