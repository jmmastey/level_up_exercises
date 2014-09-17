class Bomb
  # Communication Messages
  BOMB_DETONATED_MSG   = "Sorry, bomb has already detonated."
  BOMB_SNIPPED_MSG     = "Sorry, bomb wires have been snipped."
  BOMB_ACTIVE_MSG      = "Bomb is already active"
  BOMB_INACTIVE_MSG    = "Bomb is already inactive"
  BOMB_ACTIVATED_MSG   = "Bomb activated - Look Out!"
  BOMB_DEACTIVATED_MSG = "Bomb deactivated"
  
  TOO_MANY_DEACT_MSG   = "Bomb detonated - too many attempts!"
  WRONG_CODE_MSG       = "Wrong code"
  CODE_NOT_AN_INT_MSG  = "Code must be an integer"

  # State
  INTEGRITY_DETONATED = "Blown to shreds"
  INTEGRITY_SNIPPED   = "Wires are cut"
  INTEGRITY_INTACT    = "Intact"

  ACTIVATION_NOT_APP  = "NA"
  ACTIVATION_ACTIVE   = "Active"
  ACTIVATION_INACTIVE = "Inactive"

  # Default Codes
  DEFAULT_ACTIVATION_CODE   = "1234"
  DEFAULT_DEACTIVATION_CODE = "0000"


  def initialize(activation_code, deactivation_code)
    set_activation_code(activation_code)
    set_deactivation_code(deactivation_code)
    init_state
  end

  def init_state
    @active = false
    @snipped = false
    @deactivation_attempts = 0
  end

  def activate(code)
    return bomb_is_defunct if bomb_is_defunct
    return BOMB_ACTIVE_MSG if active?
    return CODE_NOT_AN_INT_MSG unless is_integer?(code)
    attempt_to_activate(code)
  end

  def deactivate(code)
    return bomb_is_defunct if bomb_is_defunct
    return BOMB_INACTIVE_MSG unless active?
    return CODE_NOT_AN_INT_MSG unless is_integer?(code)
    attempt_to_deactivate(code)
  end

  def snip
    return bomb_is_defunct if bomb_is_defunct
    @snipped = true
    "You have snipped the wires - bomb is now defunct"
  end

  def active?
    @active && !detonated? && !snipped?
  end

  def detonated?
    @deactivation_attempts >= 3
  end

  def snipped?
    @snipped
  end

  def to_h
    result = {}
    result["integrity"] = integrity_status
    result["activation"] = activation_status
    result["deact_attempts"] = @deactivation_attempts
    result
  end

  private
  def integrity_status
    return INTEGRITY_DETONATED if detonated?
    return INTEGRITY_SNIPPED   if snipped?
    INTEGRITY_INTACT
  end

  def activation_status
    return ACTIVATION_NOT_APP if detonated? || snipped?
    return ACTIVATION_ACTIVE if active?
    ACTIVATION_INACTIVE
  end

  def is_integer?(str)
    (str =~ /[0-9]+/)
  end

  def raise_invalid_code_error(code)
    raise ArgumentError, "Invalid code #{code}, must be an integer"
  end

  def set_activation_code(code)
    code = DEFAULT_ACTIVATION_CODE if code.empty?
    raise_invalid_code_error(code) unless is_integer?(code)
    @activation_code = code.to_i
  end

  def set_deactivation_code(code)
    code = DEFAULT_DEACTIVATION_CODE if code.empty?
    raise_invalid_code_error(code) unless is_integer?(code)
    @deactivation_code = code.to_i
  end

  def attempt_to_activate(code)
    return WRONG_CODE_MSG unless code.to_i == @activation_code
    successful_activation
  end

  def successful_activation
    @active = true 
    BOMB_ACTIVATED_MSG
  end

  def attempt_to_deactivate(code)
    if code.to_i != @deactivation_code
      return TOO_MANY_DEACT_MSG if too_many_failures?
      return WRONG_CODE_MSG
    end
    successful_deactivation
  end

  def successful_deactivation
    @active = false
    @deactivation_attempts = 0
    BOMB_DEACTIVATED_MSG
  end

  def too_many_failures?
    @deactivation_attempts += 1
    detonated?
  end

  def bomb_is_defunct
    return BOMB_DETONATED_MSG if detonated?
    return BOMB_SNIPPED_MSG if snipped?
    nil
  end
end
