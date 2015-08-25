class Anime < ActiveRecord::Base
  has_many :library_items
  has_many :users, through: :library_items
end
