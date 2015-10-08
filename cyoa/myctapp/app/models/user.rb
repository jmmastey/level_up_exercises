class User < ActiveRecord::Base
  validates :email, :password, presence: true
  validates :email, uniqueness: true, on: :create
  validates :password, length: { minimum: 8 }
end
