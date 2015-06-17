class BootError < RuntimeError; end
class TimeError < RuntimeError; end

class Bomb
  attr_accessor :status
  attr_reader :activation_code, :deactivation_code,
    :booted, :defuse_attempts, :max_defuse_time, :time_remaining
  alias_method :booted?, :booted

  def initialize(args={})
    @status = default_status
    @booted = false
    @defuse_attempts = 3
  end

  def boot(args={})
    raise BootError, "The bomb has already been booted" if booted?
    @activation_code = args.fetch(:activation_code, default_activation_code)
    @deactivation_code = args.fetch(:deactivation_code, default_deactivation_code)
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
    activate_timer
    @status = "Active"
  end

  def defuse_bomb
    @status = "Inactive"
    kill_timer
  end  

  def explode_bomb
    @status = "Exploded"
    kill_timer
  end

  def activate_timer
    @activation_time = Time.now
    @timer = Thread.new { sleep max_defuse_time; explode_bomb; }
  end

  def time_remaining
    raise TimeError, "The bomb must be active to have time remaining" if !@activation_time
    return Time.now - @activation_time
  end

  def kill_timer
    @timer.kill if @timer
    @activation_time = nil
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

  def default_defuse_time
    10
  end
end
