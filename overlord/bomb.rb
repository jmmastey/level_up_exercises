class Bomb
  MAX_ALLOWED_DEACTIVATION_ATTEMPS = 3
  DEFAULT_ACTIVATION_CODE          = '1234'
  DEFAULT_DEACTIVATION_CODE        = '0000'

  attr_reader :status

  def initialize(params={})
    @activation_code   = params[:activation_code] || DEFAULT_ACTIVATION_CODE
    @deactivation_code = params[:deactivation_code] || DEFAULT_DEACTIVATION_CODE
    @status            = :deactivated
    @attempts          = 0
  end

  def activate(code)
    @status = :activated if deactivated? && activation_code?(code)
  end

  def deactivate(code)
    return unless activated?

    if deactivation_code?(code)
      @status = :deactivated
    else
      increment_attempt_count
      try_explode
    end
  end

  def deactivated?
    @status == :deactivated
  end

  def activated?
    @status == :activated
  end

  def exploded?
    @status == :exploded
  end

  def remaining_attempts
    return 0 if @attempts > MAX_ALLOWED_DEACTIVATION_ATTEMPS
    MAX_ALLOWED_DEACTIVATION_ATTEMPS - @attempts
  end

  private

  def activation_code?(code)
    @activation_code == code
  end

  def deactivation_code?(code)
    @deactivation_code == code
  end

  def increment_attempt_count
    @attempts += 1
  end

  def  try_explode
    @status = :exploded if @attempts > MAX_ALLOWED_DEACTIVATION_ATTEMPS
  end
end
