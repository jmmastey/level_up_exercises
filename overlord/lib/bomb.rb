class Bomb
  class BombError < RuntimeError
  end

  MAX_ATTEMPTS = 3

  attr_reader :attempts_remaining

  def activated?
    @activated
  end

  def exploded?
    @exploded
  end

  def initialize(act_code = nil, deact_code = nil)
    @activated = false
    @exploded = false
    activate(act_code, deact_code) unless act_code.nil? || deact_code.nil?
  end

  def activate(activation_code, deactivation_code)
    validate_inputs(activation_code, deactivation_code)
    @activation_code = activation_code
    @deactivation_code = deactivation_code
    @attempts_remaining = MAX_ATTEMPTS - 1
    @exploded = false
    @activated = true
  end

  def deactivate(code)
    raise(BombError, "already gone bang") if @exploded
    if @deactivation_code != code
      explode_on_max_attempts
    else
      @activated = false
    end
  end

  private

  def explode_on_max_attempts
    explode if @attempts_remaining == 0
    @attempts_remaining -= 1
  end

  def explode
    @exploded = true
    @activated = false
  end

  def validate_inputs(activation_code, deactivation_code)
    raise(BombError, "already activated") if @activated
    raise(BombError, "already gone bang") if @exploded
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
