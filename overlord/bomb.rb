class Bomb
  OFF = :OFF
  BOOTED = :BOOTED
  ACTIVATED = :ACTIVATED
  DEACTIVATED = :DEACTIVATED
  EXPLODED = :EXPLODED

  DEFAULT_NUM_ATTEMPTS = 3

  attr_accessor :state, :activation_code, :deactivation_code, :attempts, :errors

  def initialize(activation_code = '1234', deactivation_code = '0000')
    @activation_code = activation_code
    @deactivation_code = deactivation_code
    @errors = []
    @state = OFF
  end

  def update(activation_code, deactivation_code)
    @activation_code = activation_code
    @deactivation_code = deactivation_code
  end

  def boot
    return unless state == OFF

    check_for_valid_codes
    return unless valid_codes?

    @state = BOOTED
    @attempts = DEFAULT_NUM_ATTEMPTS
  end

  def activate(code)
    return unless state == BOOTED

    check_for_correct_code?(code)
    return unless valid_codes?

    @state = ACTIVATED
  end

  def deactivate(code)
    return unless state == ACTIVATED

    check_for_correct_code?(code)
    return @state = DEACTIVATED if valid_codes?

    @attempts -= 1
    explode if attempts == 0
  end

  def explode
    @state = EXPLODED
  end

  def off?
    state == OFF
  end

  def booted?
    state == BOOTED
  end

  def activated?
    state == ACTIVATED
  end

  def deactivated?
    state == DEACTIVATED
  end

  def exploded?
    state == EXPLODED
  end

  private

  def valid_code?(code)
    (code =~ /^[0-9]+$/) == 0
  end

  def check_for_valid_codes
    return unless state == OFF
    errors.clear
    errors << 'Invalid activation code' unless valid_code?(activation_code)
    errors << 'Invalid deactivation code' unless valid_code?(deactivation_code)
  end

  def check_for_correct_code?(code)
    errors.clear
    if state == BOOTED
      errors << 'Wrong activation code' unless activation_code == code
    elsif state == ACTIVATED
      errors << 'Wrong deactivation code' unless deactivation_code == code
    end
  end

  def valid_codes?
    errors.empty?
  end
end
