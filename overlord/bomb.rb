class Bomb
  DEFAULT_ACTIVATION_CODE = "1234"
  DEFAULT_DEACTIVATION_CODE = "0000"
  MAX_DEACTIVATION_ATTEMPTS = 3

  attr_reader :attempts_remaining, :state, :activation_code

  def initialize(activation_code, deactivation_code)
    if activation_code.empty?
      @activation_code = DEFAULT_ACTIVATION_CODE
    else
      @activation_code = activation_code
    end
    if deactivation_code.empty?
      @deactivation_code = DEFAULT_DEACTIVATION_CODE
    else
      @attempts_remaining = MAX_DEACTIVATION_ATTEMPTS
    end
    @state = false
  end

  def try_to_activate(activation_code)
    if activation_code == @activation_code && @state == false
      @state = true
    else
      "Error"
    end
  end

  def try_to_deactivate(deactivation_code)
    if deactivation_code == @deactivation_code && state == true
      @state = false
    else
      @attempts_remaining -= 1
      if @attempts_remaining == 0
        "Boom"
      end
    end
  end
end
