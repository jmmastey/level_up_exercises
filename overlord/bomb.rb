InvalidCodeError = Class.new(RuntimeError)

class Bomb
  OFF = 0
  ON = 1
  ACTIVATED = 2
  DEACTIVATED = 3
  DESTROYED = 4

  attr_accessor :start_time, :state, :activation_code, :deactivation_code
  attr_accessor :deactivation_attempts

  def initialize
    @state = OFF
    @deactivation_attempts = 0
  end

  def valid_code?(code)
    code =~ /[0-9]+/
  end

  def set_codes(activation_code, deactivation_code)
    unless valid_code?(activation_code) && valid_code?(deactivation_code)
      raise InvalidCodeError, "Bomb attempted to boot up with invalid codes"
    end
    @activation_code = activation_code
    @deactivation_code = deactivation_code
  end

  def boot_up(activation_code = "1234", deactivation_code = "0000")
    set_codes(activation_code, deactivation_code)
    @state = ON
  end

  def activate(code)
    return unless on?
    @state = ACTIVATED if code == @activation_code || activated?
  end

  def deactivate(code)
    return unless activated?
    if code == @deactivation_code
      @state = DEACTIVATED
    else
      @deactivation_attempts += 1
      detonate if @deactivation_attempts >= 3
    end
  end

  def detonate
    return unless activated? && @deactivation_attempts >= 3
    @state = DESTROYED
  end

  def on?
    @state == ON
  end

  def off?
    @state == OFF
  end

  def activated?
    @state == ACTIVATED
  end

  def deactivated?
    @state == DEACTIVATED
  end

  def destroyed?
    @state == DESTROYED
  end
end
