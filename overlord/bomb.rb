class Bomb
  DEFAULT_ACT_CODE = "1234"
  DEFAULT_DEACT_CODE = "0000"
  MAX_DEACTIVATION_ATTEMPTS = 3

  attr_reader :attempts_remaining, :state, :activation_code, :active

  def initialize(act_code, deact_code)
    validate(act_code, deact_code)
    @activation_code = act_code.empty? ? DEFAULT_ACT_CODE : act_code
    @deactivation_code = deact_code.empty? ? DEFAULT_DEACT_CODE : deact_code
    @attempts_remaining = MAX_DEACTIVATION_ATTEMPTS
    @active = false
    @exploded = false
  end

  def try_to_activate(activation_code)
    if activation_code == @activation_code && @active == false && !@exploded
      @active = true
    end
  end

  def try_to_deactivate(deactivation_code)
    if deactivation_code == @deactivation_code && @active == true && !exploded?
      @active = false
    elsif @active == true && !exploded?
      incorrect_deactivation_code
    end
  end

  def exploded?
    @exploded
  end

  private

  def validate(act_code, deact_code)
    raise ArugmentError unless act_code === /^\d{4}$/
    raise ArugmentError unless deact_code === /^\d{4}$/
  end

  def incorrect_deactivation_code
    @attempts_remaining -= 1
      if @attempts_remaining == 0
        @active = false
        @exploded = true
      end
  end
end
