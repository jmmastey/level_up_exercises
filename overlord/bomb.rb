class Bomb
  DEFAULT_ACT_CODE = "1234"
  DEFAULT_DEACT_CODE = "0000"
  MAX_DEACTIVATION_ATTEMPTS = 3

  attr_reader :attempts_remaining, :state, :activation_code

  def initialize(act_code, deact_code)
    @activation_code = act_code.empty? ? DEFAULT_ACT_CODE : act_code
    @deactivation_code = deact_code.empty? ? DEFAULT_DEACT_CODE : deact_code
    @attempts_remaining = MAX_DEACTIVATION_ATTEMPTS
    @state = false
    @exploded = false
  end

  def try_to_activate(activation_code)
    if activation_code == @activation_code && @state == false && !@exploded
      @state = true
    else
      "Error"
    end
  end

  def try_to_deactivate(deactivation_code)
    if deactivation_code == @deactivation_code && @state == true && !@exploded
      @state = false
    elsif @state == true
      @attempts_remaining -= 1
      if @attempts_remaining == 0
        @state = false
        "Boom"
      end
    end
  end

  def exploded?
    @exploded
  end
end
