class Bomb
  attr_reader :attempts_remaining, :status

  def initialize(activation_code, deactivation_code)
    @attempts_remaining = 3
    @status = :disarmed
    @activation_code = activation_code
    @deactivation_code = deactivation_code
  end

  def time_remaining(current_time = Time.now)
    check_exploded_status(current_time)

    (@activation_time + @timer) - current_time
  end

  def activate(code, timer = 30, current_time = Time.now)
    check_exploded_status(current_time)

    if code == @activation_code
      @attempts_remaining = 3
      @activation_time = current_time
      @timer = timer
      @status = :armed
    end

    self
  end

  def deactivate(code, current_time = Time.now)
    if code != @deactivation_code
      @attempts_remaining -= 1
    else
      @status = :disarmed
    end

    check_exploded_status(current_time)
    self
  end

  private

  def check_exploded_state(current_time)
    if @attempts_remaining <= 0 ||
       (@status == :armed && @activation_time + @timer < current_time)
      @status = :exploded
    end

    raise BombExplodedError if status == :exploded
  end
end

class BombExplodedError < RuntimeError; end;
