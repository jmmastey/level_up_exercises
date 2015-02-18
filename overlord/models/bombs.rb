require 'state_machine'
require 'data_mapper'

class Bombs
  include DataMapper::Resource

  property :bomb_id, Serial, :key => true
  property :created_at, DateTime
  property :state, String
  property :timer, Integer, :default => 30
  property :attempts, Integer, :default => 0
  property :max_attempts, Integer, :default => 3
  property :disarming_code, Integer

  state_machine :state, :initial => :deactivated do
    state :deactivated
    state :activated
    state :armed
    state :disarmed
    state :detonated

    after_transition :deactivated => :activated do
      save
    end

    after_transition :activated => :armed do
      save
    end

    event :activate do
      transition :deactivated => :activated
    end

    event :arm do
      transition [:activated, :disarmed] => :armed
    end

    event :disarm do
      transition :armed => :disarmed
    end

    event :deactivate do
      transition :disarmed => :deactivated
    end

    event :detonate do
      transition :armed => :detonated
    end
  end

  private

  def delete_bomb
    destroy
  end
end
