class BombController
  DEFAULT_ACTIVATION_CODE = "1234"
  DEFAULT_DEACTIVATION_CODE = "0000"
  MAX_DEACTIVATION_ATTEMPTS = 3

  attr_accessor :wire_box
  attr_reader :activation_code, :deactivation_code, :message, :timer

  def initialize(activation_code = DEFAULT_ACTIVATION_CODE,
                 deactivation_code = DEFAULT_DEACTIVATION_CODE)
    @activation_code = activation_code
    @deactivation_code = deactivation_code
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

  def enter_code(code)
    update_state
    raise_code_format_error unless code == "" || code.match(/^\d{4}$/)
    send("enter_code_when_#{@state}", code)
  end

  def state
    update_state
    @state
  end

  def update_state
    unless @state == :disabled || @state == :exploded
      @state = :disabled if @wire_box.disabled?
      @state = :exploded if @wire_box.exploded?
    end
    @state
  end

  private

  def activate(timer_seconds)
    @timer = Timer.new(timer_seconds)
    @state = :active
    @message = "Activated"
    reset_deactivation_attempts
    update_state
  end

  def deactivate
    @state = :inactive
    @message = "Deactivated"
    update_state
  end

  def enter_code_when_active(code)
    return if code == ""
    return deactivate if code == @deactivation_code
    @message = "Invalid code"
    increment_deactivation_attempts unless ignore_invalid_code?(code)
    explode if should_explode?
  end

  def enter_code_when_activating(code)
    return deactivate if code == ""
    minutes = code.slice(0, 2).to_i
    seconds = code.slice(2, 2).to_i
    activate((minutes * 60) + seconds)
  end

  def enter_code_when_disabled(code)
    raise RuntimeError, "Bomb has been deactivated."
  end

  def enter_code_when_exploded(code)
    raise RuntimeError, "Bomb already exploded."
  end

  def enter_code_when_inactive(code)
    return if code == ""
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

  def ignore_invalid_code?(code)
    @deactivation_attempts == 0 && code == @activation_code
  end

  def increment_deactivation_attempts
    @deactivation_attempts += 1
  end

  def raise_code_format_error
    raise ArgumentError, "Invalid code format."
  end

  def reset_deactivation_attempts
    @deactivation_attempts = 0
  end

  def has_expired_timer?
    timer && timer.expired?
  end

  def should_explode?
    @state == :active && (has_expired_timer? || exhausted_deactivation_attempts?)
  end

  def start_activation_process
    update_state
    return unless @state == :inactive
    @state = :activating
    @message = "Set Timer or Enter to stop"
  end
end
