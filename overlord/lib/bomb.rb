class Bomb
  attr_accessor :activation_code, :deactivation_code, :status, :timer

  def initialize(activation_code, deactivation_code)
    @activation_code = activation_code
    @deactivation_code = deactivation_code
    @status = 'inactive'
    @timer = 0
  end

  def valid?
    return false unless activation_code =~ /^\d{4}$/
    return false unless deactivation_code =~ /^\d{4}$/
    true
  end
end
