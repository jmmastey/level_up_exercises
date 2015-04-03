class Bomb
  attr_accessor :status, :deactivation_attempts, :activation_code, :deactivation_code

  ACTIVATION_CODE = '1234'
  DEACTIVATION_CODE = '0000'

  def initialize(activation_code = ACTIVATION_CODE, deactivation_code = DEACTIVATION_CODE)
    @status = :inactive
    @deactivation_attempts = 0

    @activation_code = correct_format?(activation_code) ? activation_code : ACTIVATION_CODE
    @deactivation_code = correct_format?(deactivation_code) ? deactivation_code : DEACTIVATION_CODE
  end

  def status
    return :active if active?
    return :inactive if inactive?
    return :detonated if detonated?
  end

  def active?
    @status == :active
  end

  def inactive?
    @status == :inactive
  end

  def detonated?
    @status == :detonated
  end

  def using_default_codes?
    return true if @activation_code == ACTIVATION_CODE && @deactivation_code == DEACTIVATION_CODE

    false
  end

  def activate(code)
    return false if active?
    return false unless code == @activation_code

    successful_activation
    true
  end

  def successful_activation
    @status = :active
    @deactivation_attempts = 0
  end

  def deactivate(code)
    return false unless active?
    return failed_deactivation unless code == @deactivation_code

    @status = :inactive
    true
  end

  def failed_deactivation
    @deactivation_attempts += 1
    detonate if @deactivation_attempts == 3
    false
  end

  def detonate
    @status = :detonated
  end

  def correct_format?(code)
    !!(code =~ /\d{4,}/)
  end
end
