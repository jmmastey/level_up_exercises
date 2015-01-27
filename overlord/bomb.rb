class Bomb
  DEFAULT_ACT_CODE = "1234"
  DEFAULT_DEACT_CODE = "0000"
  MAX_DEACTIVATION_ATTEMPTS = 3

  attr_reader :attempts_remaining, :active, :exploded

  def initialize
    @active = false
    @exploded = false
    @attempts_remaining = MAX_DEACTIVATION_ATTEMPTS
  end

  def boot(act_code, deact_code)
    raise ArgumentError unless valid?(act_code) && valid?(deact_code)
    @activation_code = act_code.to_s.empty? ? DEFAULT_ACT_CODE : act_code
    @deactivation_code = deact_code.to_s.empty? ? DEFAULT_DEACT_CODE : deact_code
  end

  def activate(activation_code)
    if activation_code == @activation_code && !activated? && !exploded?
      @active = true
    end
  end

  def deactivate(deactivation_code)
    if deactivation_code == @deactivation_code && activated? && !exploded?
      deactivate_bomb
    elsif @active == true && !exploded
      incorrect_deactivation_code
    end
  end

  def activated?
    @active
  end

  def exploded?
    @exploded
  end

  def deactivated?
    !@active && !exploded
  end

  private

  def valid?(code)
    /^\d{4}$/ =~ code.to_s || code.to_s.empty?
  end

  def incorrect_deactivation_code
    @attempts_remaining -= 1 if @attempts_remaining > 0
    if @attempts_remaining <= 0
      @active = false
      @exploded = true
    end
  end

  def deactivate_bomb
    @active = false
    @attempts_remaining = MAX_DEACTIVATION_ATTEMPTS
  end
end
