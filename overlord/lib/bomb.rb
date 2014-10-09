class Bomb
  class BombError < RuntimeError
  end

  MAX_ATTEMPTS = 3

  attr_reader :status, :attempts_remaining

  def activated?
    @status == :activated
  end

  def exploded?
    @status == :exploded
  end

  def initialize(act_code = nil, deact_code = nil)
    @status = :inactivated
    @attempts_remaining = MAX_ATTEMPTS
    activate(act_code, deact_code) unless act_code.nil? || deact_code.nil?
  end

  def activate(activation_code, deactivation_code)
    validate_inputs(activation_code, deactivation_code)
    @activation_code = activation_code
    @deactivation_code = deactivation_code
    @status = :activated
  end

  def deactivate(code)
    raise(BombError, "already gone bang") if exploded?
    if code == @deactivation_code
      @status = :deactivated
    else
      explode_on_max_attempt
    end
  end

  private

  def explode_on_max_attempt
    @attempts_remaining -= 1
    explode if @attempts_remaining == 0
  end

  def explode
    @status = :exploded
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
