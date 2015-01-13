require 'dm-types'
require 'dm-validations'

class Bomb < ActiveRecord::Base
  validates_length_of :activation_code, :deactivation_code ,minimum: 4

  enum status: %w(active inactive explode)

  after_initialize :initialize_defaults

  def initialize_defaults
    self.activation_code ||= "1234"
    self.activation_code ||= "0000"
    self.detonation_time ||= 60
    self.status          ||= "inactive"
  end
end