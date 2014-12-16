class Bomb
  attr_accessor :status
  attr_reader :activation_code, :deactivation_code,
    :incorrect_deactivation_attempts

  DEFAULT_ACTIVATION_CODE = "1234"
  DEFAULT_DEACTIVATION_CODE = "0000"
  MAX_INCORRECT_ATTEMPTS = 3

  def initialize(activation_code, deactivation_code)
    @activation_code = empty_string(activation_code) || DEFAULT_ACTIVATION_CODE
    @deactivation_code = empty_string(deactivation_code) ||
                         DEFAULT_DEACTIVATION_CODE
    @status = :deactivated
    @incorrect_deactivation_attempts = 0
  end

  def analyze_user_code(code)
    case code
      when activation_code then activate
      when deactivation_code then deactivate
      else incorrect_attempt
    end
  end

  def empty_string(code)
    code if code != ""
  end

  def exploded?
    @status == :exploded
  end

  def explode!
    @status = :exploded
  end

  def incorrect_attempt
    @incorrect_deactivation_attempts += 1
    explode! if @incorrect_deactivation_attempts == MAX_INCORRECT_ATTEMPTS
  end

  def activate
    @status = :active unless @status == :exploded
  end

  def deactivate
    @status = :deactivated unless @status == :exploded
    @incorrect_deactivation_attempts = 0
  end
end
