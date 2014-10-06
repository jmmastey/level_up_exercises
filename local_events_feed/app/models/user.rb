class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 35 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }
  has_and_belongs_to_many :events
  has_secure_password
end
