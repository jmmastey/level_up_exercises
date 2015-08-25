class Card < ActiveRecord::Base
  validates :name, presence: true,
                   uniqueness: true
  serialize :colors
  serialize :types
  serialize :supertypes
  serialize :subtypes
end
