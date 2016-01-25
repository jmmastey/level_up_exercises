require "time"

class Timer
  attr_reader :detonation_time

  def initialize(seconds)
    raise ArgumentError, "Seconds must be nonnegative" if seconds < 0
    @detonation_time = Time.now + seconds
  end

  def expired?
    detonation_time <= Time.now
  end

  def seconds_remaining
    detonation_time - Time.now
  end
end
