class User < ActiveRecord::Base
  has_many :reviews

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
end
