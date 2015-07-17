class Bomb
  attr_accessor :timer, :state, :misses

  STATES = [:active, :inactive, :off, :exploded]

  def initialize(**options)
    @state = :off
    @activation_key = validate_key(options[:activation_key]) || "1234"
    @deactivation_key = validate_key(options[:deactivation_key]) || "0000"
    @timer = nil
    @misses = 0
  end

  def boot
    raise "Already Booted" unless @state == :off
    @state = :inactive
  end

  def status
    state
  end

  def exploded?
    return true if @state == :exploded
    if @state == :active && (Time.now - @timer > 120)
      @state = :exploded
      return true
    end
    false
  end

  def activate(code)
    raise "Bomb in Incorrect State" if @state != :inactive
    enter_code(code)
  end

  def deactivate(code)
    raise "Bomb in Incorrect State" if @state != :active
    enter_code(code)
  end

  def enter_code(code)
    case @state
      when :off
        raise "Code Entry Requires a Booted Bomb"
      when :active
        attempt_deactivation(code)
      when :inactive
        attempt_activation(code)
    end
  end

  def activation_key
    raise "Cannot Access Once Bomb is Booted" unless @state == :off
    @activation_key
  end

  def activation_key=(key)
    raise "Cannot Change Once Bomb is Booted" unless @state == :off
    @activation_key = validate_key(key) || @activation_key
  end

  def deactivation_key
    raise "Cannot Access Once Bomb is Booted" unless @state == :off
    @deactivation_key
  end

  def deactivation_key=(key)
    raise "Cannot Change Once Bomb is Booted" unless @state == :off
    @deactivation_key = validate_key(key) || @deactivation_key
  end

  def state
    exploded?
    @state
  end

  def state=(state)
    raise unless STATES.include?(state)
    @state = state
  end

  def inspect
    "It's a bomb"
  end

  def to_s
    "Bomb"
  end

  def time_left
    return "0:00" unless state == :active
    end_time = timer + 120
    time_remaining = (end_time - Time.now).round(0)
    return "0:00" if time_remaining < 0
    seconds = time_remaining % 60
    minutes = (time_remaining - seconds) / 60
    minutes.to_s + ":" + "%02d" % seconds
  end

  private

  def attempt_activation(code)
    raise "Incorrect Code" unless @activation_key == code
    @timer = Time.now
    @misses = 0
    @state = :active
  end

  def attempt_deactivation(code)
    raise "BOOM" if exploded?
    if @deactivation_key == code
      @state = :inactive
    else
      @misses += 1
      raise "Incorrect Code" if @misses < 3
      @state = :exploded
      raise "BOOM"
    end
  end

  def validate_key(key)
    return nil if key.nil?
    raise "Error: Invalid Key" unless (key =~ /\A[[:digit:]]{4}\Z/) == 0
    key
  end
end
