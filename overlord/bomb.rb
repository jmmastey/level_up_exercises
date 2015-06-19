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

  def boot(args={})
    raise BootError, "The bomb has already been booted" if booted?
    @activation_code = set_activation_code(args[:activation_code])
    @deactivation_code = set_deactivation_code(args[:deactivation_code])
    @max_defuse_time = default_defuse_time
    @booted = true
    @status = "Inactive"
  end

  def apply_code(code)
    return activate_bomb if @status == "Inactive" && code == activation_code
    return defuse_bomb if @status == "Active" && code == deactivation_code
    return @defuse_attempts -= 1 if code != activation_code && defuse_attempts > 1
    if code != activation_code && defuse_attempts == 1
      explode_bomb
      @defuse_attempts -= 1
      return
    end
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

  def set_activation_code(code)
    (code.nil? || code.empty?) ? "1234" : code
  end

  def set_deactivation_code(code)
    (code.nil? || code.empty?) ? "0000" : code
  end

  def default_defuse_time
    10
  end
end
