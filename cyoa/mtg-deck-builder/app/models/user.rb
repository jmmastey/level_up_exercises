class User < ActiveRecord::Base
  validates :username, presence: true,
                       uniqueness: true,
                       length: { maximum: 50 }
  has_secure_password
  validates :password, presence: true,
                       confirmation: true,
                       length: { minimum: 6, maximum: 255 }
end
