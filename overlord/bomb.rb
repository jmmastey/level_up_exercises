class Bomb
  # Communication Messages
  RESPOND_ALREADY_ACTIVE   = 'Bomb is already active'
  RESPOND_ALREADY_INACTIVE = 'Bomb is already inactive'
  RESPOND_ACTIVATED        = 'Bomb activated - Look Out!'
  RESPOND_DEACTIVATED      = 'Bomb deactivated'
  RESPOND_DETONATION       = 'Bomb has been detonated!'
  RESPOND_JUST_SNIPPED     = 'Bomb wires snipped and is now defunct'
  RESPOND_ALREADY_EXPLODED = 'Sorry, bomb has already exploded.'
  RESPOND_ALREADY_SNIPPED  = 'Sorry, bomb wires have been snipped.'

  RESPOND_TOO_MANY_DEACT   = 'Bomb exploded - too many attempts!'
  RESPOND_WRONG_CODE       = 'Wrong code'
  RESPOND_CODE_NOT_AN_INT  = 'Code must be an integer'

  # State
  INTEGRITY_EXPLODED  = 'Blown to shreds'
  INTEGRITY_SNIPPED   = 'Wires are cut'
  INTEGRITY_INTACT    = 'Intact'

  ACTIVATION_NOT_APPLICABLE  = 'NA'
  ACTIVATION_ACTIVE          = 'Active'
  ACTIVATION_INACTIVE        = 'Inactive'

  # Default Codes
  DEFAULT_ACTIVATION_CODE = '1234'
  DEFAULT_DEACTIVATION_CODE = '0000'


  def initialize(activation_code = DEFAULT_ACTIVATION_CODE, deactivation_code = DEFAULT_DEACTIVATION_CODE)
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
    return RESPOND_ALREADY_ACTIVE if active?
    return RESPOND_CODE_NOT_AN_INT unless integer?(code)
    attempt_to_activate(code)
  end

  def deactivate(code)
    return bomb_is_defunct if bomb_is_defunct
    return RESPOND_ALREADY_INACTIVE unless active?
    return RESPOND_CODE_NOT_AN_INT unless integer?(code)
    attempt_to_deactivate(code)
  end

  def snip
    return bomb_is_defunct if bomb_is_defunct
    @snipped = true
    RESPOND_JUST_SNIPPED
  end

  def detonate
    return bomb_is_defunct if bomb_is_defunct
    @detonated = true
    RESPOND_DETONATION
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
    code = DEFAULT_ACTIVATION_CODE unless integer?(code)
    @activation_code = code
  end

  def set_deactivation_code(code)
    code = DEFAULT_DEACTIVATION_CODE unless integer?(code)
    @deactivation_code = code
  end

  def attempt_to_activate(code)
    return RESPOND_WRONG_CODE unless code == @activation_code
    successful_activation
  end

  def successful_activation
    @active = true
    RESPOND_ACTIVATED
  end

  def attempt_to_deactivate(code)
    return unsuccessful_deactivation unless code == @deactivation_code
    successful_deactivation
  end

  def unsuccessful_deactivation
      @deactivation_attempts += 1
      return RESPOND_TOO_MANY_DEACT if too_many_failures?
      return RESPOND_WRONG_CODE
  end

  def successful_deactivation
    @active = false
    @deactivation_attempts = 0
    RESPOND_DEACTIVATED
  end

  def too_many_failures?
    @deactivation_attempts >= 3
  end

  def bomb_is_defunct
    return RESPOND_ALREADY_EXPLODED if exploded?
    return RESPOND_ALREADY_SNIPPED if snipped?
    nil
  end
end
