class Region < ActiveRecord::Base
  has_many :orders, dependent: :destroy

  validates_presence_of :in_game_id, :name
  validates_numericality_of :in_game_id,
                            only_integer: true,
                            greater_than_or_equal_to: 0

  scope :with_in_game_id, ->(in_game_id) { where(in_game_id: in_game_id) }
end
