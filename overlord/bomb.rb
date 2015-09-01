class Bomb
  attr_accessor :status

  def initialize(activation = '', deactivation = '')
    replace_empty_params(activation, deactivation)
    @activation_code = activation
    @deactivation_code = deactivation
    @deactivation_attempts = 0
    @status = 'Inactive'
  end

  def activate(code)
    @status = 'Active' if valid_activation_code?(code)
    active?
  end

  def deactivate(code)
    check_deactivation_code(code)
    check_deactivation_attempts
    deactivated?
  end

  def self.validate_codes(activation, deactivation)
    error = 0
    error = 1 unless Bomb.valid_code?(activation)
    error = 2 unless Bomb.valid_code?(deactivation)
    Bomb.error_codes(error)
  end

  def self.valid_code?(code)
    !!Integer(code)
  rescue ArgumentError, TypeError
    '' == code
  end

  def self.error_codes(error)
    case error
      when 1
        'Invalid activation code. Activation code must be only numbers.'
      when 2
        'Invalid deactivation code. Deactivation code must be only numbers'
      else
        nil
    end
  end

  def inactive?
    status == 'Inactive'
  end

  def active?
    status == 'Active'
  end

  def deactivated?
    status == 'Deactivated'
  end

  def blown_up?
    status == 'Blown Up'
  end

  private
  def check_deactivation_attempts
    return if deactivated? || @deactivation_attempts <= 2
    @status = 'Blown Up'
  end

  def check_deactivation_code(code)
    return if deactivated? || blown_up?
    if @deactivation_code == code
      @status = 'Deactivated'
    else
      @deactivation_attempts += 1
    end
  end

  def valid_activation_code?(code)
    @activation_code == code && @status != 'Active'
  end

  def replace_empty_params(activation, deactivation)
    activation.replace('1234') if activation == '' || activation.nil?
    deactivation.replace('0000') if deactivation == '' || deactivation.nil?
  end
end
