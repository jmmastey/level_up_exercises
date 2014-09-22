require_relative "timer"

class BombController
  DEFAULT_ACTIVATION_CODE = "1234"
  DEFAULT_DEACTIVATION_CODE = "0000"
  MAX_DEACTIVATION_ATTEMPTS = 3

  attr_accessor :wire_box
  attr_reader :activation_code, :deactivation_code, :message, :timer

  def initialize(activation_code = nil,
                 deactivation_code = nil)
    @activation_code = normalize_code(activation_code) || DEFAULT_ACTIVATION_CODE
    @deactivation_code = normalize_code(deactivation_code) || DEFAULT_DEACTIVATION_CODE
    @state = :inactive
    @message = "Booted"
    @timer = nil
  end

  def default_activation_code
    DEFAULT_ACTIVATION_CODE
  end

  def default_deactivation_code
    DEFAULT_DEACTIVATION_CODE
  end

  def disable_bomb
    @state = :disabled
    @message = "Bomb disabled"
    @timer = nil
  end

  def enter_code(code)
    code = normalize_code(code)
    update_state
    raise_code_format_error unless code.nil? || code.match(/^\d{4}$/)
    send("enter_code_when_#{@state}", code)
  end

  def state
    update_state
    @state
  end

  def update_state
    unless @state == :disabled || @state == :exploded
      @wire_box.check_booby_traps if @state == :active
      disable_bomb if @wire_box.disabled?
      if @wire_box.exploded?
        @state = :exploded
        @message = "Exploded"
      end
    end
    @state
  end

  private

  def activate(timer_seconds)
    @timer = Timer.new(timer_seconds)
    @state = :active
    @message = "Activated bomb"
    reset_deactivation_attempts
    update_state
  end

  def check_detonation
    @wire_box.check_booby_traps
    explode_if_triggered
  end

  def deactivate
    @state = :inactive
    @message = "Deactivated bomb"
    @timer = nil
    update_state
  end

  def enter_code_when_active(code)
    return if code.nil?
    return deactivate if code == @deactivation_code
    @message = "Invalid code"
    increment_deactivation_attempts unless ignore_invalid_code?(code)
    explode_if_triggered
  end

  def enter_code_when_activating(code)
    return deactivate if code.nil?
    minutes = code.slice(0, 2).to_i
    seconds = code.slice(2, 2).to_i
    activate((minutes * 60) + seconds)
    explode_if_triggered
  end

  def enter_code_when_disabled(code)
    raise RuntimeError, "Bomb has been deactivated."
  end

  def enter_code_when_exploded(code)
    raise RuntimeError, "Bomb already exploded."
  end

  def enter_code_when_inactive(code)
    return if code.nil?
    return start_activation_process if code == @activation_code
    @message = "Invalid code"
  end

  def exhausted_deactivation_attempts?
    @deactivation_attempts >= MAX_DEACTIVATION_ATTEMPTS
  end

  def explode
    update_state
    wire_box.send_to_device(:explode) if @state == :active
    update_state
  end

  def explode_if_triggered
    explode if should_explode?
  end

  def has_expired_timer?
    timer && timer.expired?
  end

  def ignore_invalid_code?(code)
    @deactivation_attempts == 0 && code == @activation_code
  end

  def increment_deactivation_attempts
    @deactivation_attempts += 1
  end

  def normalize_code(code)
    return nil if (code == "")
    code
  end

  def raise_code_format_error
    raise ArgumentError, "Invalid code format."
  end

  def reset_deactivation_attempts
    @deactivation_attempts = 0
  end

  def should_explode?
    @state == :active && (has_expired_timer? || exhausted_deactivation_attempts?)
  end

  def start_activation_process
    update_state
    return unless @state == :inactive
    @state = :activating
    @message = "Set Timer (mmss)\n or Enter to stop"
  end
end
