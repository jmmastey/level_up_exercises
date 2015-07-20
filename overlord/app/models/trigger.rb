class Trigger
  DEFAULT_ACTIVATION_CODE = '1234'
  DEFAULT_DEACTIVATION_CODE = '0000'

  attr_reader :activation_code, :deactivation_code

  def initialize
    @active = false
    @activation_code = DEFAULT_ACTIVATION_CODE
    @deactivation_code = DEFAULT_DEACTIVATION_CODE
  end

  def activate(code)
    @active = true if valid?(code) && correct_activation?(code)
  end

  def deactivate(code)
    @active = false if valid?(code) && correct_deactivation?(code)
  end

  def activated?
    @active
  end

  def deactivated?
    !activated?
  end

  def correct_activation?(code)
    code == activation_code
  end

  def correct_deactivation?(code)
    code == deactivation_code
  end

  def valid?(code)
    code =~ /(^\d{4}$)/ ? true : false
  end
end
