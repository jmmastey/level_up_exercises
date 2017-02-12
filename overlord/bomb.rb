class InvalidCodeError < ArgumentError; end

class Bomb
  attr_reader :arm_code, :disarm_retries, :state

  ARM_CODE_DFLT = "1234"
  DISARM_CODE_DFLT = "0000"
  DISARM_RETRIES_MAX = 3
  STATES = {
    :inactive => "INACTIVE",
    :armed => "ARMED",
    :exploded => "EXPLODED",
  }

  def initialize(arm_code = ARM_CODE_DFLT, disarm_code = DISARM_CODE_DFLT)
    unless Bomb.code_valid?(arm_code) && Bomb.code_valid?(disarm_code)
      raise InvalidCodeError
    end

    @arm_code = arm_code
    @disarm_code = disarm_code
    @state = STATES[:inactive]
    @disarm_retries = DISARM_RETRIES_MAX
  end

  def self.code_valid?(code)
    code.match(/[^0-9]/) ? false : true
  end

  def self.arm_code_default
    ARM_CODE_DFLT
  end

  def self.disarm_code_default
    DISARM_CODE_DFLT
  end

  def disarm(code)
    return false unless armed?

    if disarm_code_match?(code)
      disarm_code_success
      return true
    end

    disarm_code_fail
    false
  end

  def arm(code)
    return false unless inactive?
    @state = STATES[:armed] if arm_code_match?(code)
    true
  end

  def inactive?
    state == STATES[:inactive]
  end

  def armed?
    state == STATES[:armed]
  end

  def exploded?
    state == STATES[:exploded]
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
