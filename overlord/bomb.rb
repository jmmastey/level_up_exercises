class Bomb
  DEFAULT_ACT_CODE = "1234"
  DEFAULT_DEACT_CODE = "0000"
  MAX_DEACTIVATION_ATTEMPTS = 3

  attr_reader :attempts_remaining, :active, :exploded

  def initialize(act_code, deact_code)
    @activation_code = valid?(act_code) ? act_code : DEFAULT_ACT_CODE
    @deactivation_code = valid?(deact_code) ? deact_code : DEFAULT_DEACT_CODE
    @attempts_remaining = MAX_DEACTIVATION_ATTEMPTS
    @active = false
    @exploded = false
  end

  def try_to_activate(activation_code)
    if activation_code == @activation_code && !@active && !@exploded
      @active = true
    end
  end

  def try_to_deactivate(deactivation_code)
    if deactivation_code == @deactivation_code && @active && !exploded
      @active = false
    elsif @active == true && !exploded
      incorrect_deactivation_code
    end
  end

  private

  def valid?(code)
    /^\d{4}$/ =~ code.to_s
  end

  def incorrect_deactivation_code
    @attempts_remaining -= 1
    if @attempts_remaining == 0
      @active = false
      @exploded = true
    end
  end
end
