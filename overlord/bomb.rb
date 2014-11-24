class Bomb
  attr_accessor :status, :incorrect_deactivation_attempts
  attr_reader :activation_code, :deactivation_code

  DEFAULT_CODES = {
    activation: "1234",
    deactivation: "0000",
  }

  MAX_INCORRECT_ATTEMPTS = 3

  def initialize(activation_code: "1234", deactivation_code: "0000")
    @activation_code = validate_numericality(:activation, activation_code)
    @deactivation_code = validate_numericality(:deactivation, deactivation_code)
    @status = :deactivated
    @incorrect_deactivation_attempts = 0
  end

  def validate_numericality(type, code)
    if code =~ /^[\d]+$/
      code
    else
      DEFAULT_CODES[type]
    end
  end

  def activate
    @status = :active
  end

  def deactivate
    @status = :deactivated
    @incorrect_deactivation_attempts = 0
  end

  def explode!
    @status = :exploded
  end

  def analyze_user_code(code)
    case code
      when activation_code then activate
      when deactivation_code then deactivate
      else incorrect_attempt
    end
  end

  def incorrect_attempt
    @incorrect_deactivation_attempts += 1
    explode! if @incorrect_deactivation_attempts == MAX_INCORRECT_ATTEMPTS
  end
end
