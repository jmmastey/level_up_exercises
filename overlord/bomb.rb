class Bomb
  # Communication Messages
  BOMB_ACTIVE_MSG           = 'Bomb is already active'
  BOMB_INACTIVE_MSG         = 'Bomb is already inactive'
  BOMB_ACTIVATED_MSG        = 'Bomb activated - Look Out!'
  BOMB_DEACTIVATED_MSG      = 'Bomb deactivated'
  BOMB_DETONATION_MSG       = 'Bomb has been detonated!'
  BOMB_JUST_SNIPPED_MSG     = 'Bomb wires snipped and is now defunct'
  BOMB_ALREADY_EXPLODED_MSG = 'Sorry, bomb has already exploded.'
  BOMB_ALREADY_SNIPPED_MSG  = 'Sorry, bomb wires have been snipped.'
  
  CODE_TOO_MANY_DEACT_MSG = 'Bomb exploded - too many attempts!'
  CODE_WRONG_VALUE_MSG    = 'Wrong code'
  CODE_NOT_AN_INT_MSG     = 'Code must be an integer'

  # State
  INTEGRITY_EXPLODED  = 'Blown to shreds'
  INTEGRITY_SNIPPED   = 'Wires are cut'
  INTEGRITY_INTACT    = 'Intact'

  ACTIVATION_NOT_APPLICABLE  = 'NA'
  ACTIVATION_ACTIVE          = 'Active'
  ACTIVATION_INACTIVE        = 'Inactive'

  # Default Codes
  DEFAULT_ACTIVATION_CODE   = '1234'
  DEFAULT_DEACTIVATION_CODE = '0000'


  def initialize(activation_code, deactivation_code)
    set_activation_code(activation_code)
    set_deactivation_code(deactivation_code)
    initialize_state
  end

  def initialize_state
    @active = false
    @snipped = false
    @deactivation_attempts = 0
    @detonated = false
  end

  def activate(code)
    return bomb_is_defunct if bomb_is_defunct
    return BOMB_ACTIVE_MSG if active?
    return CODE_NOT_AN_INT_MSG unless integer?(code)
    attempt_to_activate(code)
  end

  def deactivate(code)
    return bomb_is_defunct if bomb_is_defunct
    return BOMB_INACTIVE_MSG unless active?
    return CODE_NOT_AN_INT_MSG unless integer?(code)
    attempt_to_deactivate(code)
  end

  def snip
    return bomb_is_defunct if bomb_is_defunct
    @snipped = true
    BOMB_JUST_SNIPPED_MSG
  end

  def detonate
    return bomb_is_defunct if bomb_is_defunct
    @detonated = true
    BOMB_DETONATION_MSG
  end

  def active?
    @active && !exploded? && !snipped?
  end

  def exploded?
    @deactivation_attempts >= 3 || @detonated
  end

  def snipped?
    @snipped
  end

  def to_h
    result = {}
    result['integrity'] = integrity_status
    result['activation'] = activation_status
    result['deact_attempts'] = @deactivation_attempts
    result
  end

  private
  def integrity_status
    return INTEGRITY_EXPLODED if exploded?
    return INTEGRITY_SNIPPED   if snipped?
    INTEGRITY_INTACT
  end

  def activation_status
    return ACTIVATION_NOT_APPLICABLE if exploded? || snipped?
    return ACTIVATION_ACTIVE if active?
    ACTIVATION_INACTIVE
  end

  def integer?(str)
    (str =~ /[0-9]+/)
  end

  def raise_invalid_code_error(code)
    raise ArgumentError, "Invalid code #{code}, must be an integer"
  end

  def set_activation_code(code)
    code = DEFAULT_ACTIVATION_CODE if code.empty?
    raise_invalid_code_error(code) unless integer?(code)
    @activation_code = code.to_i
  end

  def set_deactivation_code(code)
    code = DEFAULT_DEACTIVATION_CODE if code.empty?
    raise_invalid_code_error(code) unless integer?(code)
    @deactivation_code = code.to_i
  end

  def attempt_to_activate(code)
    return CODE_WRONG_VALUE_MSG unless code.to_i == @activation_code
    successful_activation
  end

  def successful_activation
    @active = true 
    BOMB_ACTIVATED_MSG
  end

  def attempt_to_deactivate(code)
    if code.to_i != @deactivation_code
      return CODE_TOO_MANY_DEACT_MSG if too_many_failures?
      return CODE_WRONG_VALUE_MSG
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
    exploded?
  end

  def bomb_is_defunct
    return BOMB_ALREADY_EXPLODED_MSG if exploded?
    return BOMB_ALREADY_SNIPPED_MSG if snipped?
    nil
  end
end
