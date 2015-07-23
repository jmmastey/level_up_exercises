class Bomb
  TWO_MINUTES = 120
  attr_reader :state, :attempts_remaining, :timer_end

  def initialize(custom_activation_code = nil, custom_deactivation_code = nil)
    @default_activation_code = "1234"
    @default_deactivation_code = "0000"

    @custom_activation_code = custom_activation_code
    @custom_deactivation_code = custom_deactivation_code

    @state = "Deactivated"
    @timer_end = 0
    @attempts_remaining = 3
  end

  def activate
    @state = "Activated"
    start_timer
    @attempts_remaining = 3
  end

  def deactivate
    @state = "Deactivated"
  end

  def explode
    @state = "Exploded"
  end

  def start_timer
    @timer_end = (Time.now + TWO_MINUTES).to_i
  end

  def correct_activation_code?(code)
    code == @default_activation_code || code == @custom_activation_code
  end

  def correct_deactivation_code?(code)
    code == @default_deactivation_code || code == @custom_deactivation_code
  end

  def decrement_attempt
    @attempts_remaining -= 1
  end
end
