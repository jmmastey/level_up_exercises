class Bomb
  DEFAULT_ACTIVATION_CODE = 1234
  DEFAULT_DEACTIVATION_CODE = 0000
  MAX_DEACTIVATION_ATTEMPTS = 3

  attr_reader :attempts_remaining, :state

  def initialize(
    activation_code = DEFAULT_ACTIVATION_CODE, 
    deactivation_code = DEFAULT_DEACTIVATION_CODE
  )
    @activation_code = activation_code
    @deactivation_code = deactivation_code
    @attempts_remaining = MAX_DEACTIVATION_ATTEMPTS
    @state = false
  end

  def active?
    @state
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
      if exploded?
        "Boom"
      end
    end
  end

  def exploded?
    @attempts_remaining == 0
  end
end
