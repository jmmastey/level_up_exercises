class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save { self.email = email.downcase }
  before_create :create_member_token

  validates :name, presence: true, length: { maximum: 35 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }

  has_and_belongs_to_many :events
  has_secure_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def add_event(event)
    events << event unless event.has_match_in?(events)
  end

  def remove_event(event)
    events.delete(event)
  end

  private

  def create_member_token
    self.remember_token = User.digest(User.new_remember_token)
  end
end
