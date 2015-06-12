class Bomb
  attr_accessor :status
  attr_reader :activation_code, :deactivation_code

  def initialize()
    @status = default_status
  end

  def boot(args={})
    @activaiton_code = args.fetch(:activaiton_code, default_activation_code)
    @deactivaiton_code = args.fetch(:deactivaiton_code, default_deactivation_code)
    @status = "Inactive"
  end

  def apply_code(code)
  end

  def default_status
    "Offline"
  end

  def default_activation_code
    1234
  end

  def default_deactivation_code
    "0000"
  end

end
