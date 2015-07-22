class Trigger
  DEFAULT_ACTIVATION_CODE = '1234'
  DEFAULT_DEACTIVATION_CODE = '0000'

  attr_reader :activation_code, :deactivation_code

  def initialize(options = {})
    @options = options
    @active = false
    @attempts = 0
    setup_activation_code
    setup_deactivation_code
  end

  def activate(code)
    @active = true if valid?(code) && correct_activation?(code)
  end

  def deactivate(code)
    return if detonated?
    @attempts += 1

    reset_bomb if valid?(code) && correct_deactivation?(code)
  end

  def activated?
    @active
  end

  def deactivated?
    !activated?
  end

  def correct_activation?(code)
    code == activation_code
  end

  def correct_deactivation?(code)
    code == deactivation_code
  end

  def valid?(code)
    code =~ /(^\d{4}$)/ ? true : false
  end

  def detonated?
    @attempts > 2
  end

  private

  def reset_bomb
    @active = false
    @attempts = 0
  end

  def setup_activation_code
    if @options[:activate].nil? || @options[:activate].empty?
      @activation_code = DEFAULT_ACTIVATION_CODE
    else
      @activation_code = @options[:activate]
    end
  end

  def setup_deactivation_code
    if @options[:deactivate].nil? || @options[:deactivate].empty?
      @deactivation_code = DEFAULT_DEACTIVATION_CODE
    else
      @deactivation_code = @options[:deactivate]
    end
  end
end
