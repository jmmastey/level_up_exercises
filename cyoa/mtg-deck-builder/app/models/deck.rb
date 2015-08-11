class Deck < ActiveRecord::Base
  has_and_belongs_to_many :cards
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true
end
