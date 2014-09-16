class Bomb
  attr_reader :activation_code, :deactivation_code

  def initialize(activation_code, deactivation_code)
    @activation_code = activation_code
    @deactivation_code = deactivation_code
    @wires_intact = true
  end

  def wires_intact?
    @wires_intact
  end
end
