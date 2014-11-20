class Bomb
  attr_accessor :activation_code, :deactivation_code

  def initialize(activation_code: 1234, deactivation_code: 0000)
    @activation_code = activation_code
    @deactivation_code = deactivation_code
  end
end
