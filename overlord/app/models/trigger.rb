class Trigger
  DEFAULT_ACTIVATION_CODE = '1234'

  attr_reader :activation_code

  def initialize
    @active = false
    @activation_code = DEFAULT_ACTIVATION_CODE
  end

  def activate(code)
    if valid?(code) && correct_activation?(code)
      @active = true if valid?(code)
    end
  end

  def deactivate(code)
    @active = false if valid?(code)
  end

  def activated?
    @active
  end

  def deactivated?
    !activated?
  end

  def correct_activation?(code)
    code == @activation_code
  end

  private

  def valid?(code)
    code =~ /(^\d{4}$)/ ? true : false
  end
end
