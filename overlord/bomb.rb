class Bomb

  ACTIVATION_CODE = '1234'
  DEACTIVATION_CODE = '0000'
  COUNTDOWN = 60
  ALLOWED_RETRIES = 3
  #BOMB_STATE = { unbooted: "Not Booted",  booted: "Booted", active: "Active", deactivated: "Deactivated", detonated: "Detonated" }
  attr_accessor :activation_code, :deactivation_code, :state, :retries

  def initialize(activation_code = ACTIVATION_CODE, deactivation_code = DEACTIVATION_CODE)
    @activation_code = ACTIVATION_CODE
    @deactivation_code = DEACTIVATION_CODE
    @state = :unbooted
    @retries = 0 
  end

  def bomb_state
    @state
  end

  def boot_bomb
    @state = :booted
  end

  def activate(code)
    if valid_activation_code?(code)
      @state = :active
      true
    else
      false
    end
  end

  def deactivate(code)
    if valid_deactivation_code?(code)
      @state = :deactivated
      true
    else
      false
    end
  end

  def countdown
  end

  def valid_activation_code?(code)
    if code == ACTIVATION_CODE
      true
    else
      false
    end
  end

  def valid_deactivation_code?(code)
    if code == DEACTIVATION_CODE
      true
    else
      false
    end
  end
end
