class Bomb
  TWO_MINUTES = 120
  attr_reader :state, :attempts_remaining, :timer_end

  def initialize(custom_activation_code = nil, custom_deactivation_code = nil)
    @activation_code = custom_activation_code || "1234"
    @deactivation_code = custom_deactivation_code || "0000"

    @state = "Deactivated"
    @timer_end = 0
    @attempts_remaining = 3
  end

  def activate(code)
    valid = @activation_code == code && @state == "Deactivated"
    if valid
      @state = "Activated"
      start_timer
      @attempts_remaining = 3
      true
    else
      false
    end
  end

  def deactivate(code)
    if @state == "Activated"
      if @deactivation_code == code
        @state = "Deactivated"
        return true
      else
        invalid_attempt
      end
    end
    false
  end

  def explode_if_timer_out
    explode_bomb if @timer_end - Time.now.to_i <= 0
  end

  def start_timer
    @timer_end = (Time.now + TWO_MINUTES).to_i
  end

  private

  def invalid_attempt
    @attempts_remaining -= 1
    return unless @attempts_remaining == 0
    explode_bomb
  end

  def explode_bomb
    @state = "Exploded"
  end
end
