BombCodeError = Class.new(RuntimeError)

BOMB_DURATION = 10
class Bomb
  attr_reader :time_remaining
  attr_reader :state
  attr_reader :num_deactivation_attempts

  def initialize(activation_code, deactivation_code)
    @activation_code = set_code(activation_code, "1234")
    @deactivation_code = set_code(deactivation_code, "0000")
    @state = "inactive" # inactive, active, exploded
    @num_deactivation_attempts = 3
    @time_remaining = BOMB_DURATION # seconds
    @explosion_time = nil  # This shouldn't be set until the bomb is activated
  end

  def set_code(code, default)
    return code if code =~ /^\d{4}$/
    return default if code == ""
    raise BombCodeError, "Your code, #{code}, is invalid. Choose a 4 digit code."
  end

  def start_bomb(activation_code)
    return "Bomb cannot be started (wrong state)." if @state != "inactive"
    return 'Invalid activation code' if @activation_code != activation_code
    @state = "active"
    @explosion_time = Time.now + @time_remaining
    @num_deactivation_attempts = 3
  end

  def update_remaining_time
    @time_remaining = (@explosion_time - Time.now).round
    explode_bomb if @time_remaining <= 0
    @time_remaining
  end

  def attempt_deactivation(deactivation_code)
    return 'Bomb already exploded.' if @state == "exploded"
    return 'Bomb is not currently active.' if @state == "inactive"
    if @deactivation_code == deactivation_code && @num_deactivation_attempts > 0
      @state = "inactive"
      update_remaining_time
    else
      @num_deactivation_attempts -= 1
      explode_bomb if @num_deactivation_attempts <= 0
    end
  end

  def explode_bomb
    @state = "exploded"
  end
end
