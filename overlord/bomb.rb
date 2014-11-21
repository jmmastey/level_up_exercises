class Bomb
  attr_accessor :activation_code, :deactivation_code, :status

  DEFAULT_CODES = {
    :activation => "1234",
    :deactivation => "0000",
  }

  def initialize(activation_code: "1234", deactivation_code: "0000")
    @activation_code = validate_numericality(:activation, activation_code)
    @deactivation_code = validate_numericality(:deactivation, deactivation_code)
    @status = :inactivated
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

  def explode!
    @status = :exploded
  end

  def test_user_code(code)
    if code == activation_code
      :activate
    elsif code == deactivation_code
      :deactivate
    else
      :not_a_match
    end
  end
end
