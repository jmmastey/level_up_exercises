class InvalidCodeError < ArgumentError; end
class LockedCodeError < StandardError; end

class Bomb
  attr_reader :state

  ARM_CODE_DEFAULT = "1234"
  DISARM_CODE_DEFAULT = "0000"
  DISARM_RETRIES_MAX = 3
  STATES = {
    :inactive => "INACTIVE",
    :armed => "ARMED",
    :exploded => "EXPLODED",
   }

  def initialize
    @arm_code = ARM_CODE_DEFAULT
    @disarm_code = DISARM_CODE_DEFAULT
    @state = STATES[:inactive]
    @disarm_retries = DISARM_RETRIES_MAX

    if !(valid_code?(@arm_code) && valid_code?(@disarm_code))
      raise InvalidCodeError
    end
  end

  def valid_code?(code)
    code.match(/[^0-9]/) ? false : true 
  end

  def arm_code=(code)
    raise LockedCodeError unless state == STATES[:inactive]
    raise InvalidCodeError unless valid_code?(code)
    @arm_code = code
  end

  def disarm_code=(code)
    raise LockedCodeError unless state == STATES[:inactive]
    raise InvalidCodeError unless valid_code?(code)
    @disarm_code = code
  end

  def disarm(code)
    return false unless state == STATES[:armed]

    if disarm_code_match?(code)
      disarm_code_success
      return true
    end

    disarm_code_fail
    false
  end

  def arm(code)
    return false unless state == STATES[:inactive]
    @state = STATES[:armed] if arm_code_match?(code)
    true
  end

  private

  def arm_code_match?(code)
    code == @arm_code
  end

  def disarm_code_match?(code)
    code == @disarm_code
  end

  def disarm_code_success
    @state = STATES[:inactive]
    @disarm_retries = DISARM_RETRIES_MAX
  end

  def disarm_code_fail
    @disarm_retries -= 1
    explode if @disarm_retries == 0
  end

  def explode
    @state = STATES[:exploded]
  end
end
