class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save { self.email = email.downcase }
  before_create :create_member_token

  validates :name, presence: true, length: { maximum: 35 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }

  has_and_belongs_to_many :showings
  has_secure_password

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def add_showing(showing)
    showings << showing unless showing.in?(showings)
  end

  def has_showing_in?(event)
    showings.any? { |showing| showing.in?(event.showings) }
  end

  private

  def create_member_token
    self.remember_token = User.new_remember_token
  end
end
