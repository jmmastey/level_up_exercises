class Bomb
  attr_accessor :activation_code, :deactivation_code, :status

  def initialize(activation_code: "0000", deactivation_code: "0000")
    @activation_code = activation_code
    @deactivation_code = deactivation_code
    @status = :inactive
  end


end
