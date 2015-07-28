require_relative 'bomb_state'
class Bomb
  DEFAULT_NUM_ATTEMPTS = 3

  attr_accessor :state, :activation_code, :deactivation_code, :attempts, :errors

  def initialize(activation_code = '1234', deactivation_code = '0000')
    @activation_code = activation_code
    @deactivation_code = deactivation_code
    @errors = []
    @state = BombState::OFF
  end

  def update(activation_code, deactivation_code)
    @activation_code = activation_code
    @deactivation_code = deactivation_code
  end

  def boot
    return unless off?

    check_for_valid_codes
    return unless valid_codes?

    @state = BombState::BOOTED
    @attempts = DEFAULT_NUM_ATTEMPTS
  end

  def activate(code)
    return unless booted?

    check_for_correct_code?(code)
    return unless valid_codes?

    @state = BombState::ACTIVATED
  end

  def deactivate(code)
    return unless activated?

    check_for_correct_code?(code)
    return @state = BombState::DEACTIVATED if valid_codes?

    @attempts -= 1
    explode if attempts == 0
  end

  def explode
    @state = BombState::EXPLODED
  end

  def off?
    state == BombState::OFF
  end

  def booted?
    state == BombState::BOOTED
  end

  def activated?
    state == BombState::ACTIVATED
  end

  def deactivated?
    state == BombState::DEACTIVATED
  end

  def exploded?
    state == BombState::EXPLODED
  end

  private

  def valid_code?(code)
    (code =~ /^[0-9]+$/) == 0
  end

  def check_for_valid_codes
    return unless off?
    errors.clear
    errors << 'Invalid activation code' unless valid_code?(activation_code)
    errors << 'Invalid deactivation code' unless valid_code?(deactivation_code)
  end

  def check_for_correct_code?(code)
    errors.clear
    if booted?
      errors << 'Wrong activation code' unless activation_code == code
    elsif activated?
      errors << 'Wrong deactivation code' unless deactivation_code == code
    end
  end

  def valid_codes?
    errors.empty?
  end
end
