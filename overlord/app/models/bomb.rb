# File bomb.rb
require 'active_support/time'
class Bomb
  include DataMapper::Resource
  property :id, Serial
  property :activation_code, Integer, default: 1234
  property :deactivation_code, Integer, default: 0000
  property :session_id, String, required: true
  property :detonation_time, Time, required: true
  property :created_at, DateTime, default: DateTime.current
  property :status, Enum[:inactive, :active, :exploded, :defused], default: :inactive
  property :attempts, Integer, default: 0, max: 3

  validates_length_of :activation_code, :deactivation_code, min: 4
  has n, :wires
end
