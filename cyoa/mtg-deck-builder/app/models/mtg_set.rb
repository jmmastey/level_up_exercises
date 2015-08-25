class MtgSet < ActiveRecord::Base
  has_and_belongs_to_many :cards
  validates :set_id, presence: true,
                     uniqueness: true
  validates :name, presence: true,
                   uniqueness: true
  validates :set_type, presence: true
end
