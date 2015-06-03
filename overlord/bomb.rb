class Bomb
  attr_accessor :status
  def initialize(activation_code: "1234", deactivation_code: "0000")
    @activation_code = activation_code.to_s
    @deactivation_code = deactivation_code.to_s
    @status = :inactive
    @attempt_count = 0
  end

  def valid_activation_code?(activation_code)
    activation_code.to_s == @activation_code
  end

  def valid_deactivation_code?(deactivation_code)
    deactivation_code.to_s == @deactivation_code
  end

  def activate(code)
    @status = :active if valid_activation_code? code
  end

  def active?
    @status == :active
  end

  def detonated?
    @status == :detonated
  end

  def deactivate(code)
    if valid_deactivation_code? code
      @status = :inactive
    else
      @attempt_count += 1
      @status = :detonated if @attempt_count >= 3
    end
  end
end
