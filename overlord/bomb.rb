class Bomb
  ACTIVE_CODE = '1234'
  DEACTIVE_CODE = '0000'
  WRONG_ATTEMPTS = 3
  attr_reader :status, :incorrect_attempts

  def initialize(active_code, deactive_code)
    @activation_code = active_code.empty? ? ACTIVE_CODE : active_code
    @deactivation_code = deactive_code.empty? ? DEACTIVE_CODE : deactive_code
    @incorrect_attempts = 0
    @status = 'deactivated'
  end

  def check_input_code(code)
    if @status == 'activated'
      if code == @deactivation_code
        deactivate
      else
        incorrect_attempt
      end
    elsif @status == 'deactivated'
      activate if code == @activation_code
    end
  end

  def incorrect_attempt
    @incorrect_attempts += 1
    @status = 'blasted' if @incorrect_attempts == WRONG_ATTEMPTS
  end

  def activate
    @status = 'activated' unless @status == 'blasted'
    @incorrect_attempts = 0 unless @status == 'blasted'
  end

  def deactivate
    @status = 'deactivated' unless @status == 'blasted'
    @incorrect_attempts = 0 unless @status == 'blasted'
  end
end
