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

  def activation_code
    @activation_code
  end

  def deactivation_code
    @deactivation_code
  end

  def disarm_attempts_left
    [ALLOWED_DISARM_ATTEMPTS - @disarm_attempts,0].max
  end

  def last_disarm_attempt_successful?
    @disarm_attempts == 0
  end

  def valid_code? string
    true if string.nil? || Float(string) rescue false
  end

  def active?
    @booted
  end

  def armed?
    @armed
  end

  def load (options ={})

    # return self if @armed

    @booted = true

    if valid_code?(options[:activation_code])
      @activation_code = options[:activation_code] unless options[:activation_code].to_s ==""
    else
      @booted = false unless options[:activation_code].to_s ==""
    end

    if valid_code?(options[:deactivation_code])
      @deactivation_code = options[:deactivation_code] unless options[:deactivation_code].to_s ==""
    else
      @booted = false unless options[:deactivation_code].to_s ==""
    end

    self
  end

  def arm(code)
    @armed = code == @activation_code unless @armed
    self
  end

  def disarm(code)
    if(code == @deactivation_code)
      @armed = false
      @disarm_attempts = 0
    else
      @disarm_attempts += 1
      @detonated = @disarm_attempts >= ALLOWED_DISARM_ATTEMPTS
    end
    self
  end

end