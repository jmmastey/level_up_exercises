require 'json'
require 'set'

class User < ActiveRecord::Base
  attr_accessor :remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
  # serialize :favorite_routes, String

  # returns hash digest of given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # remembers a user in the database for use in persistence sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # returns true if given token matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end

  # adds a route to user favorites if not already existing
  def favorite_add(route)
    favorite_routes = favorite_route_list
    return false if favorite_routes.any? { |h| h["stop_id"] == route[:stop_id] }
    favorite_routes << route
    self.favorite_routes = JSON.generate(favorite_routes)
    return true if self.save
    return false
  end

  # adds a route to user favorites if not already existing
  def favorite_remove(route)
    favorite_routes = favorite_route_list
    return false unless favorite_routes.any? { |h| h["stop_id"] == route[:stop_id] }
    favorite_routes.reject! { |h| h["stop_id"] == route[:stop_id] }
    self.favorite_routes = JSON.generate(favorite_routes)
    return true if self.save
    return false
  end

  # parses the stored JSON favorite_routes
  def favorite_route_list
    return [] if self.favorite_routes.nil?
    JSON.parse(self.favorite_routes)
  end
end
