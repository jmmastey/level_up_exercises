class Bomb
  attr_accessor :status, :activation_code, :diactivation_code, :wrong_attempts

  DEFAULT_ACTIVATION_CODE = '1234'
  DEFAULT_DEACTIVATION_CODE = '0000'
  WRONG_ATTEMPTS_LIMIT = 3

  def initialize(activation_code = DEFAULT_ACTIVATION_CODE, deactivation_code = DEFAULT_DEACTIVATION_CODE)
    @status = :inactive
    @activation_code = activation_code
    @deactivation_code = deactivation_code
    @wrong_attempts = 0
  end

  def self.valid_code?(code)
    /^\d{4,}$/ === code
  end

  def activate(activate_code)
    if activate_code == @activation_code
      @status = :active
      @wrong_attempts = 0
    end
  end

  def deactivate(deactivate_code)
    if deactivate_code == @deactivation_code
      @status = :inactive
    else
      @wrong_attempts += 1
      explode if remaining_attempts == 0
    end
  end

  def remaining_attempts
    WRONG_ATTEMPTS_LIMIT - @wrong_attempts
  end

  def explode
    @status = :boom
  end
end
