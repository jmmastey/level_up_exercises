class Bomb
  OFF = 0
  ON = 1
  ACTIVATED = 2
  DEACTIVATED = 3
  DESTROYED = 4

  attr_accessor :start_time, :state, :activation_code, :deactivation_code
  attr_accessor :deactivation_attempts, :time_limit

  def initialize(time_limit = 30)
    @state = OFF
    @timer = time_limit
    @deactivation_attempts = 0
  end

  def readable_state
    %w(Off On Activated Deactivated Destroyed)[@state]
  end

  def valid_code?(code)
    code =~ /^[0-9]+$/
  end

  def set_codes(a_code, d_code)
    return false unless valid_code?(a_code) && valid_code?(d_code)
    @activation_code = a_code
    @deactivation_code = d_code
    true
  end

  def boot_up(activation_code = "1234", deactivation_code = "0000")
    set_codes_successfully = set_codes(activation_code, deactivation_code)
    @state = ON if set_codes_successfully
  end

  def activate(code)
    return @state unless on?
    return @state unless code == @activation_code
    @start_time = Time.now
    @state = ACTIVATED
  end

  def deactivate(code)
    if code == @deactivation_code
      @state = DEACTIVATED
    else
      @deactivation_attempts += 1
      detonate if @deactivation_attempts >= 3
    end
    @state
  end

  def detonate
    @state = DESTROYED
  end

  def attempts_left
    3 - @deactivation_attempts
  end

  def time_limit
    limit = @timer < 10 ? "0" : ""
    limit + @timer.to_s
  end

  def time_left
    return unless activated?
    elapsed = Time.now.to_i - @start_time.to_i
    left = @timer - elapsed
    left < 0 ? 0 : left
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
