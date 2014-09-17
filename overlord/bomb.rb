class Bomb
  attr_reader :activation_code, :deactivation_code

  def initialize(options = {})
    @active = false
    @activation_code = options[:activation_code] || 1234
    @deactivation_code = options[:deactivation_code] || 0

    raise ArgumentError unless valid_input?
  end

  def activated?
    @active
  end

  private

  def valid_input?
    int_in_range?(activation_code) && int_in_range?(deactivation_code)
  end

  def int_in_range?(input)
    input.is_a?(Integer) && input.between?(0,9999)
  end
end
