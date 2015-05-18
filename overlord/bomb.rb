class Bomb
  attr_reader :error_count
  attr_reader :status

  def initialize(activation_code = '1234', deactivation_code = '0000')
    @activation_code = activation_code
    @deactivation_code = deactivation_code
    @status = 'inactive'
    reset_errors
  end

  def activate(code)
    return false if code != @activation_code || @status == 'exploded'
    @status = 'active'
    reset_errors
  end

  def deactivate(code)
    return false if @status == 'exploded'
    if code == @deactivation_code
      @status = 'inactive'
      reset_errors
    else
      log_error
    end
  end

  private

  def explode
    @status = 'exploded'
    reset_errors
  end

  def log_error
    @error_count += 1
    explode if @error_count >= 3
  end

  def reset_errors
    @error_count = 0
  end
end
