class Bomb
  attr_accessor :active, :detonated,
   :deactivation_attempts, :activation_code, :deactivation_code

  def initialize(activation_code = '1234', deactivation_code = '0000')
    @active = false
    @detonated = false
    @deactivation_attempts = 0

    correct_activation = (activation_code !~ /\D/) && (activation_code.length > 3)
    @activation_code = correct_activation ? activation_code : '1234'

    correct_deactivation = (deactivation_code !~ /\D/) && (deactivation_code.length > 3)
    @deactivation_code = correct_deactivation ? deactivation_code : '0000'
  end

  def is_active?
    return @active
  end

  def is_detonated?
    return @detonated
  end

  def activate(code)
    return false if is_active?

    if code == @activation_code
      @active = true
      @deactivation_attempts = 0
      return true
    else
      return false
    end
  end

  def deactivate(code)
    return false if !(is_active?)

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
end
