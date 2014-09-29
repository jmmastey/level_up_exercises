class Bomb
  class BombError < RuntimeError
  end

  MAX_ATTEMPTS = 3

  protected

  attr_accessor :status,
                :attempts_remaining,
                :deactivation_code,
                :activation_code

  public

  def status
    @status
  end

  def activated?
    self.status == :activated
  end

  def exploded?
    self.status == :exploded
  end

  def initialize(act_code = nil, deact_code = nil)
    self.status = :inactivated
    self.attempts_remaining = MAX_ATTEMPTS - 1
    activate(act_code, deact_code) unless act_code.nil? || deact_code.nil?
  end

  def activate(activation_code, deactivation_code)
    validate_inputs(activation_code, deactivation_code)
    self.activation_code = activation_code
    self.deactivation_code = deactivation_code
    self.status = :activated
  end

  def deactivate(code)
    raise(BombError, "already gone bang") if exploded?
    if code == self.deactivation_code
      self.status = :deactivated
    else
      explode_on_max_attempts
    end
  end

  private

  def explode_on_max_attempts
    explode if self.attempts_remaining == 0
    self.attempts_remaining -= 1
  end

  def explode
    self.status = :exploded
  end

  def validate_inputs(activation_code, deactivation_code)
    raise(BombError, "already activated") if self.activated?
    raise(BombError, "already gone bang") if self.exploded?
    validate_codes(activation_code, deactivation_code)
  end

  def validate_codes(activation, deactivation)
    msg = " code must be 4 numbers"
    raise(ArgumentError, "activation#{msg}") unless validate(activation)
    raise(ArgumentError, "deactivation#{msg}") unless validate(deactivation)
  end

  def validate(code)
    /^\d{4}$/.match(code)
  end
end
