class Bomb

  attr_reader :bomb_status, :deactivation_attempts, :activation_code,
              :deactivation_code

  def initialize()
    bomb_status = :deactivated
    @deactivation_attempts = 3
    puts "Initialized"
  end

  def activate(activation_code, deactivation_code)
    validate_codes(activation_code,deactivation_code)
    @activation_code = activation_code
    @deactivation_code = deactivation_code
    bomb_status = :activated
  end

  def deactivate(code)
    raise(StandardError, "Too late!") if exploded?
    @deactivation_attempts -= 1
    if code == deactivation_code
      @bomb_status = :deactivated
    else
      raise(StandardError, "Too Many Attempts") if @deactivation_attempts <= 0
    end
  end

  def activated?
    @bomb_status == :activated
  end

  def exploded?
    @bomb_status == :exploded
  end

  private

  def validate_codes(activation, deactivation)
    raise(StandardError, "Bomb Is Already Active") if self.activated?
    raise(StandardError, "Bomb Exploded") if self.exploded?
    raise(StandardError, "Activation and Deactivation codes must be
          different") if activation == deactivation
  end

end
