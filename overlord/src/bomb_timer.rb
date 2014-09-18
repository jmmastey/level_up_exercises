require "active_support/time"
require "thread"

class TimerError < RuntimeError; end

class BombTimer
  SECONDS_REMAINING = 30

  def initialize(remaining = SECONDS_REMAINING)
    @seconds_remaining = remaining.seconds
    @started = false
  end

  def start
    raise(TimerError, "cannot start the timer. it is already running") if started?
    @deadline = Time.now + @seconds_remaining
    @started = true
  end

  def stop
    raise(TimerError, "cannot stop the timer. it is not running") unless started?
    @seconds_remaining = (deadline - Time.now)
    @started = false
  end

  def triggered?
    deadline < Time.now
  end

  def deadline
    @deadline
  end

  def seconds_remaining
    if started?
      Time.now - deadline
    else
      @seconds_remaining
    end
  end

  def reset(remaining = SECONDS_REMAINING)
    @seconds_remaining = remaining.seconds
    @deadline = Time.now + @seconds_remaining
  end

  def started?
    @started
  end
end
