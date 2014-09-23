class Bomb
  attr_reader :activation_code, :deactivation_code, :deactivation_attempts

  def initialize(activation_code = "1234", deactivation_code = "0000")
    @active = false
    @exploded = false
    @deactivation_attempts = 0
    @wires = true

    @activation_code = activation_code
    @deactivation_code = deactivation_code
    raise ArgumentError unless valid_input?
  end

  def activated?
    @active
  end

  def exploded?
    @exploded
  end

  def has_snipped_wires?
    !@wires
  end

  def status
    return "detonated" if has_snipped_wires?
    return "exploded" if exploded?
    return "activated" if activated?
    "deactivated"
  end

  def activate(code)
    @active = true if code == activation_code
    @deactivation_attempts = 0
  end

  def deactivate(code)
    if code == deactivation_code
      @active = false
    else
      @deactivation_attempts += 1
      explode if @deactivation_attempts >= 3
    end
  end

  def snip_wires
    @wires = false
  end

  private

  def valid_input?
    @activation_code = "1234" if activation_code == ""
    @deactivation_code = "0000" if deactivation_code == ""
    matches_code_pattern?(activation_code) && matches_code_pattern?(deactivation_code)
  end

  def matches_code_pattern?(input)
    return false unless input.is_a? String
    /^\d{4}$/ =~ input
  end

  def explode
    @exploded = true
  end
end
