require 'dm-types'
require 'dm-validations'

class Bomb < ActiveRecord::Base
  validates_length_of :activation_code, :deactivation_code, minimum: 4
  validates :activation_code, :deactivation_code, format: { with: /\A[0-9]*\z/ }
  enum status: %w(active inactive explode)

  has_many :wires
  before_validation :initialize_defaults

  def match_activation_code?(code)
    activation_code == code &&
      inactive?
  end

  def match_deactivation_code?(code)
    deactivation_code == code &&
      active?
  end

  def activate
    active!
    self.activated_time = Time.now
    failed_attempts = 0
    save!
  end

  def deactivate
    inactive!
    self.activated_time = nil
    failed_attempts = 0
    save!
  end

  def explode
    explode!
    self.activated_time = nil
    save!
  end

  private

  def initialize_defaults
    self.activation_code   ||= "1234"
    self.deactivation_code ||= "0000"
    self.detonation_time   ||= 60
    self.status            ||= "inactive"
    self.failed_attempts   ||= 0
  end
end
