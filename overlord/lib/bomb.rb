class Bomb
  class BombError < RuntimeError
  end

  def initialize(activation_code = nil, deactivation_code = nil)
    @activated = false
    activate(activation_code, deactivation_code) unless activation_code.nil? || deactivation_code.nil?
  end

  def activate(activation_code, deactivation_code)
    raise(BombError, "already activated") if @activated
    raise(ArgumentError, "activation code must be 4 numbers") unless /^\d{4}$/.match(activation_code)
    raise(ArgumentError, "deactivation code must be 4 numbers") unless /^\d{4}$/.match(deactivation_code)
    @activation_code = activation_code
    @deactivation_code = deactivation_code
    @activated = true
  end
end
