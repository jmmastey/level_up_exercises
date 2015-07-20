class Bomb
  attr_reader :activation_code, :deactivation_code
  attr_reader :armed
  attr_reader :booted
  attr_reader :detonated
  attr_reader :disarm_attempts

  ALLOWED_DISARM_ATTEMPTS = 3

  def initialize
    @activation_code = '1234'
    @deactivation_code = '0000'
    @booted = false
    @armed = false
    @detonated = false
    @disarm_attempts = 0
  end

  def disarm_attempts_left
    [ALLOWED_DISARM_ATTEMPTS - @disarm_attempts, 0].max
  end

  def last_disarm_successful?
    @disarm_attempts == 0
  end

  def active?
    @booted
  end

  def armed?
    @armed
  end

  def valid_code?(string)
    true if Float(string) rescue false
  end

  def boot(arming = nil, disarming = nil)
    @booted = true
    load_disarm_code(disarming)
    load_arm_code(arming)
    self
  end

  def arm(code)
    @armed = code == @activation_code unless @armed
    self
  end

  def disarm(code)
    (code == @deactivation_code) ? successful_disarm : failed_disarm
    self
  end

  private

  def load_arm_code(arming)
    if valid_code?(arming)
      @activation_code = arming.to_s
    else
      @booted = false unless arming.to_s.empty?
    end
  end

  def load_disarm_code(disarming)
    if valid_code?(disarming)
      @deactivation_code = disarming.to_s
    else
      @booted = false unless disarming.to_s.empty?
    end
  end

  def failed_disarm
    @disarm_attempts += 1
    @detonated = @disarm_attempts >= ALLOWED_DISARM_ATTEMPTS
  end

  def successful_disarm
    @armed = false
    @disarm_attempts = 0
  end
end
