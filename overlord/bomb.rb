BombCodeError = Class.new(RuntimeError)
BombStateError = Class.new(RuntimeError)

BOMB_DURATION = 10
class Bomb
  attr_reader :time_remaining
  attr_reader :state
  attr_reader :num_deactivation_attempts
  attr_reader :has_been_activated
  attr_reader :activation_code
  attr_reader :deactivation_code

  def initialize(activation_code, deactivation_code)
    @activation_code = set_code(activation_code, "1234")
    @deactivation_code = set_code(deactivation_code, "0000")
    @state = :inactive # :inactive, :active, :exploded
    @has_been_activated = false # tracks whether bomb activated at least once
    @num_deactivation_attempts = 3
    @time_remaining = BOMB_DURATION # seconds
    @explosion_time = nil  # This isn't known until the bomb is activated
  end

  def set_code(code, default)
    return code if code_valid?(code)
    return default if code.empty?
    raise BombCodeError, "Your code (#{code}) is invalid. Choose 4 digit code."
  end

  def attempt_activation(activation_code)
    return BombStateError unless @state == :inactive
    return BombCodeError if @activation_code != activation_code
    start_bomb
  end

  def update_remaining_time
    @time_remaining = (@explosion_time - Time.now).round
    explode_bomb if @time_remaining <= 0
    @time_remaining
  end

  def attempt_deactivation(deactivation_code)
    return BombStateError if @state != :active
    deactivate if possible_to_deactivate?(deactivation_code)
    apply_penalty if !possible_to_deactivate?(deactivation_code)
  end

  private

  def start_bomb
    @state = :active
    @has_been_activated = true
    @explosion_time = Time.now + @time_remaining
    @num_deactivation_attempts = 3
  end

  def apply_penalty
    @num_deactivation_attempts -= 1
    explode_bomb if @num_deactivation_attempts <= 0
  end

  def possible_to_deactivate?(deactivation_code)
    @deactivation_code == deactivation_code && @num_deactivation_attempts > 0
  end

  def deactivate
    @state = :inactive
    update_remaining_time
  end

  def explode_bomb
    @state = :exploded
  end

  def code_valid?(code)
    code =~ /^\d{4}$/
  end
end
