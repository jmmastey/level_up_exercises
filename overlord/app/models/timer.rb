require 'active_support/time'

class Timer
  DEFAULT_COUNTDOWN = 30

  attr_reader :started, :time_remaining, :detonation

  def initialize(countdown = DEFAULT_COUNTDOWN)
    @time_remaining = countdown.seconds
    @started = false
  end

  def start
    @detonation = Time.now + @time_remaining
    @started = true
  end

  def stop
    @time_remaining = (@detonation - Time.now)
    @started = false
    @detonation = nil
  end

  def time_remaining
    return (@detonation - Time.now).floor if started?
    @time_remaining.floor
  end

  def started?
    started
  end

  def detonated?
    return false unless started?
    @detonation < Time.now
  end

  def reset(time = DEFAULT_COUNTDOWN)
    @time_remaining = time.seconds
    @detonation = Time.now + @time_remaining
  end
end
