class Bomb
  attr_reader :status, :failed_deactivation_attempts
  attr_accessor :activation_code, :deactivation_code

  def initialize(activation, deactivation)
    @activation_code = activation
    @deactivation_code = deactivation
    @status = :inactive
    @failed_deactivation_attempts = 0
  end

  def active?
    status == :active
  end

  def disabled?
    status == :disabled
  end

  def exploded?
    status == :exploded
  end

  def explode
    @status = :exploded if status == :active
    self
  end

  def explode!
    @status = :exploded if status == :active
  end

  def enter_code(code)
    return attempt_activation(code) if status == :inactive
    return attempt_deactivation(code) if status == :active
  end

  def attempt_activation(code)
    return activate if code == activation_code
  end

  def attempt_deactivation(code)
    return self if code == activation_code
    return deactivate if code == deactivation_code
    @failed_deactivation_attempts += 1
    explode! if @failed_deactivation_attempts > 2
    self
  end

  def cut_wires
    @status = :disabled
    self
  end

  def cut_wires!
    @status = :disabled
  end

  private

  def activate
    @status = :active
    self
  end

  def deactivate
    @status = :inactive
    self
  end
end
