class Book < ActiveRecord::Base
  validates(:title, presence: true)
  has_and_belongs_to_many :users
end
