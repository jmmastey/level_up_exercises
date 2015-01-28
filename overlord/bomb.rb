class Bomb
  DEFAULT_ACT_CODE = "1234"
  DEFAULT_DEACT_CODE = "0000"
  MAX_DEACTIVATION_ATTEMPTS = 3

  attr_reader :attempts_remaining, :bad_act_code

  def initialize
    @active = false
    @exploded = false
    @booted = false
    @attempts_remaining = MAX_DEACTIVATION_ATTEMPTS
    @bad_act_code = false
  end

  def boot(act_code = "", deact_code = "")
    return unless !exploded? && !activated? && !deactivated?
    raise ArgumentError unless valid?(act_code) && valid?(deact_code)
    @activation_code = assign_act_code(act_code)
    @deactivation_code = assign_deact_code(deact_code)
    @booted = true
  end

  def activate(code)
    if code == @activation_code && deactivated?
      @active = true
      @bad_act_code = false
    else
      @bad_act_code = true
    end
  end

  def deactivate(code)
    if code == @deactivation_code && activated?
      deactivate_bomb
    elsif activated?
      incorrect_deactivation_code
    end
  end

  def activated?
    @active && !@exploded && @booted
  end

  def exploded?
    @exploded
  end

  def deactivated?
    !@active && !@exploded && @booted
  end

  private

  def valid?(code)
    /^\d{4}$/ =~ code.to_s || code.to_s.empty?
  end

  def assign_act_code(code)
    code.to_s.empty? ? DEFAULT_ACT_CODE : code.to_s
  end

  def assign_deact_code(code)
    code.to_s.empty? ? DEFAULT_DEACT_CODE : code.to_s
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
