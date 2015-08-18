class Bomb
  attr_accessor :status

  def initialize(activation = nil, deactivation = nil)
    @activation_code = activation || '1234'
    @deactivation_code = deactivation || '0000'
    @deactivation_attempts = 0
    @status = 'Inactive'
  end

  def activate(code)
    @status = 'Active' if check_activation_code(code)
    @status == 'Active'
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

  def self.validate_codes(activation, deactivation)
    return 1 unless Bomb.valid_code?(activation)
    return 2 unless Bomb.valid_code?(deactivation)
    0
  end

  def self.valid_code?(code)
    !!Integer(code)
  rescue ArgumentError, TypeError
    '' == code
  end

  private

  def check_activation_code(code)
    @activation_code == code && @status != 'Active'
  end
end
