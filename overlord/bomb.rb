class Bomb
  def initialize(activation = 1234, deactivation = 0000)
    @activation_code = activation
    @deactivation_code = deactivation
    @deactivation_attempts = 0
    @status = 'Inactive'
  end

  def activate(code)
    @status = 'Active' if @activation_code == code
  end

  def deactivate(code)
    @deactivation_attempts += 1
    if @deactivation_code == code
      @status = 'Inactive'
    elsif @deactivation_attempts == 2
      @status = 'Blown Up'
    end
  end

  def status
    @status
  end

end