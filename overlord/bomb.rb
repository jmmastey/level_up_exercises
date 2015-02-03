class Bomb
  MAX_ALLOWED_DEACTIVATION_ATTEMPTS = 3
  DEFAULT_ACTIVATION_CODE          = '1234'
  DEFAULT_DEACTIVATION_CODE        = '0000'

  attr_reader :status

  def initialize(params = {})
    raise ArgumentError unless valid?(params[:activation_code]) && valid?(params[:deactivation_code])
    @activation_code   = params[:activation_code] || DEFAULT_ACTIVATION_CODE
    @deactivation_code = params[:deactivation_code] || DEFAULT_DEACTIVATION_CODE
    @status            = :deactivated
    @attempts          = 0
  end

  def activate(code)
    raise RuntimeError unless deactivated?
    @status = :activated if deactivated? && is_activation_code?(code)
  end

  def deactivate(code)
    raise RuntimeError unless activated?

    if is_deactivation_code?(code)
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
    return 0 if @attempts > MAX_ALLOWED_DEACTIVATION_ATTEMPTS
    MAX_ALLOWED_DEACTIVATION_ATTEMPTS - @attempts
  end

  private

  def valid?(code)
    /^\d{4}$/ =~ code.to_s || code.to_s.empty?
  end

  def is_activation_code?(code)
    @activation_code == code
  end

  def is_deactivation_code?(code)
    @deactivation_code == code
  end

  def increment_attempt_count
    @attempts += 1
  end

  def  try_explode
    @status = :exploded if @attempts > MAX_ALLOWED_DEACTIVATION_ATTEMPTS
  end
end
