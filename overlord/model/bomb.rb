require 'state_machine'

class Bomb
  state_machine :state, :initial => :deactivated do
    state :deactivated
    state :activated
    state :armed
    state :disarmed
    state :detonated

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

  def initialize
    # This is required because without this state machine's states
    # will not get initialized. - believe in me, Svajone.
    super()
  end
end
