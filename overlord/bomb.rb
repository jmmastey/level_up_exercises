class Bomb
  attr_accessor :active, :detonated,
   :deactivation_attempts, :activation_code, :deactivation_code

  def initialize(activation_code = '1234', deactivation_code = '0000')
    @active = false
    @detonated = false
    @deactivation_attempts = 0

    @activation_code = correct_format?(activation_code) ? activation_code : '1234'
    @deactivation_code = correct_format?(deactivation_code) ? deactivation_code : '0000'
  end

  def active?
    @active
  end

  def detonated?
    @detonated
  end

  def activate(code)
    return false if active?

    if code == @activation_code
      @active = true
      @deactivation_attempts = 0
      return true
    else
      return false
    end
  end

  def deactivate(code)
    return false if !(active?)

    if code == @deactivation_code
      @active = false
      return true
    else
      @deactivation_attempts += 1
      if @deactivation_attempts == 3
        @detonated = true
        @active = false
        return false
      else
        return false
      end
    end
  end

  def correct_format?(code)
    (code !~ /\D/) && (code.length > 3)
  end
end
