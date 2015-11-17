require "time"

class Timer
  attr_reader :detonation_time

  def initialize(seconds)
    raise ArgumentError, "Seconds must be nonnegative" if seconds < 0
    @detonation_time = Time.now.utc + seconds
  end

  def expired?
    detonation_time <= Time.now.utc
  end

  def seconds_remaining
    detonation_time - Time.now.utc
  end

  def to_s
    rounded_time_remaining = seconds_remaining.round
    minutes_remaining = (rounded_time_remaining / 60).to_i
    seconds_remaining_in_last_minute = rounded_time_remaining % 60
    '%d:%02d' % [minutes_remaining, seconds_remaining_in_last_minute]
  end
end
