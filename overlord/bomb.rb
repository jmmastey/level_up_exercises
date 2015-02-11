require 'state_machine'
class Bomb
  DEFAULT_ACTIVATION_CODE = "1234"
  DEFAULT_DEACTIVATION_CODE = "0000"
  MAX_ATTEMPTS = 3

  attr_accessor :attempts_remaining, :activation_code, :deactivation_code, :state

  state_machine :state, initial: :pending do
    event :build do
      transition pending: :built
    end

    event :deactivate do
      transition [:built, :activated] => :deactivated
    end

    event :activate do
      transition [:deactivated, :invalid] => :activated
    end

    event :invalidate do
      transition any => :invalid
    end

    event :explode do
      transition [:activated, :invalid] => :exploded
    end
  end

  def initialize
    @attempts_remaining = MAX_ATTEMPTS
    @activation_code = DEFAULT_ACTIVATION_CODE
    @deactivation_code = DEFAULT_DEACTIVATION_CODE
    super() # Needed for the state machine to initialize
    self.build!
  end

  def boot(activation, deactivation)
    raise ArgumentError unless valid?(activation) && valid?(deactivation)
    self.activation_code = activation unless activation.empty?
    self.deactivation_code = deactivation unless deactivation.empty?
    self.deactivate!
  end

  def activation_attempt(code)
    raise ArgumentError unless valid?(code)
    code == activation_code ? self.activate! : self.invalidate!
  end

  def deactivation_attempt(code)
    raise ArgumentError unless valid?(code)
    code == deactivation_code ? self.deactivate! : invalid_attempt
  end

  def status
    state.to_sym
  end

  private

  def valid?(code)
    /^\d{4}$/ =~ code || code.empty?
  end

  def invalid_attempt
    self.invalidate!
    self.attempts_remaining -= 1
    explode if attempts_remaining == 0
  end
end
