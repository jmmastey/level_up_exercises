class Bomb
  def initialize(activation = '', deactivation = '')
    setup_activation_code(activation)
    setup_deactivation_code(deactivation)
    @deactivation_attempts = 0
    @status = 'Inactive'
  end

  def setup_activation_code(activation)
    if activation == ''
      @activation_code = '1234'
    else
      @activation_code = activation
    end
  end

  def setup_deactivation_code(deactivation)
    if deactivation == ''
      @deactivation_code = '0000'
    else
      @deactivation_code = deactivation
    end
  end

  def activate(code)
    if @activation_code == code && @status != 'Active'
      @status = 'Active'
      true
    else
      false
    end
  end

  def deactivate(code)
    if @deactivation_code == code
      @status = 'Deactivated'
      true
    elsif @deactivation_attempts >= 2
      @status = 'Blown Up'
      false
    end
    @deactivation_attempts += 1
  end

  def status_reader
    @status
  end

  def self.valid_code?(code)
    !!Integer(code)
  rescue ArgumentError, TypeError
    '' == code
  end
end
