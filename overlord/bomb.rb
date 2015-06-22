class BootError < RuntimeError; end
class InvalidActivationCode < RuntimeError; end

class Bomb
  attr_reader :status, :activation_code, :deactivation_code,
    :booted, :defuse_attempts
  alias_method :booted?, :booted

  def initialize
    @status = default_status
    @booted = false
    @defuse_attempts = 3
  end

  def boot(args = {})
    raise BootError, "The bomb has already been booted" if booted?
    @activation_code = default_activation_code(args[:activation_code])
    @deactivation_code = default_deactivation_code(args[:deactivation_code])
    @booted = true
    @status = "Inactive"
  end

  def apply_code(code)
    case @status
      when "Inactive"
        apply_inactive(code)
      when "Active"
        apply_active(code)
    end
  end

  def apply_inactive(code)
    activate_bomb if code == activation_code
  end

  def apply_active(code)
    code == deactivation_code ? defuse_bomb : attempt_defuse(code)
  end

  def attempt_defuse(code)
    @defuse_attempts -= 1 unless code == activation_code
    explode_bomb if @defuse_attempts <= 0
  end

  def activate_bomb
    @status = "Active"
  end

  def defuse_bomb
    @status = "Inactive"
  end

  def explode_bomb
    @status = "Exploded"
  end

  def default_status
    "Offline"
  end

  def default_activation_code(code)
    code.to_s.empty? ? "1234" : code
  end

  def default_deactivation_code(code)
    code.to_s.empty? ? "0000" : code
  end
end
