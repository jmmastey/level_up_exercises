class Bomb
  DEFAULT_ACT_CODE = "1234"
  DEFAULT_DEACT_CODE = "0000"
  MAX_DEACTIVATION_ATTEMPTS = 3

  attr_reader :attempts_remaining, :bad_activation_code

  def initialize
    @state = :unbooted
    @attempts_remaining = MAX_DEACTIVATION_ATTEMPTS
    @bad_activation_code = false
    @already_booted = false
  end

  def boot(act_code = '', deact_code = '')
    raise RuntimeError unless @state == :unbooted
    raise ArgumentError unless valid?(act_code) && valid?(deact_code)
    @activation_code = assign_act_code(act_code)
    @deactivation_code = assign_deact_code(deact_code)
    @state = :deactivated
  end

  def activate(code)
    raise RuntimeError unless deactivated?
    if code == @activation_code
      @state = :activated
      @bad_activation_code = false
    else
      @bad_activation_code = true
    end
  end

  def deactivate(code)
    raise RuntimeError unless activated?
    if code == @deactivation_code
      deactivate_bomb
    else
      incorrect_deactivation_code
    end
  end

  def unbooted?
    @state == :unbooted
  end

  def deactivated?
    @state == :deactivated
  end

  def activated?
    @state == :activated
  end

  def exploded?
    @state == :exploded
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
      @state = :exploded
    end
  end

  def deactivate_bomb
    @state = :deactivated
    @attempts_remaining = MAX_DEACTIVATION_ATTEMPTS
  end
end
