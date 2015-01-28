class Bomb
  DEFAULT_ACT_CODE = "1234"
  DEFAULT_DEACT_CODE = "0000"
  MAX_DEACTIVATION_ATTEMPTS = 3

  attr_reader :attempts_remaining, :bad_activation_code

  def initialize
    @active = false
    @exploded = false
    @booted = false
    @attempts_remaining = MAX_DEACTIVATION_ATTEMPTS
    @bad_activation_code = false
  end

  def boot(act_code = "", deact_code = "")
    return unless not_booted?
    raise ArgumentError unless valid?(act_code) && valid?(deact_code)
    @activation_code = assign_act_code(act_code)
    @deactivation_code = assign_deact_code(deact_code)
    @booted = true
  end

  def activate(code)
    return unless deactivated?
    if code == @activation_code
      @active = true
      @bad_activation_code = false
    else
      @bad_activation_code = true
    end
  end

  def deactivate(code)
    return unless activated?
    if code == @deactivation_code
      deactivate_bomb
    elsif activated?
      incorrect_deactivation_code
    end
  end

  def activated?
    @booted && @active && !@exploded
  end

  def exploded?
    @booted && @active && @exploded
  end

  def deactivated?
    @booted && !@active && !@exploded
  end

  def not_booted?
    !@booted && !@active && !@exploded
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
      @exploded = true
    end
  end

  def deactivate_bomb
    @active = false
    @attempts_remaining = MAX_DEACTIVATION_ATTEMPTS
  end
end
