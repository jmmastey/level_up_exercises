require "activesupport"
require "thread"

class TimerError < RuntimeError; end

class BombTimer
  SECONDS_REMAINING = 30

  def initialize(remaining = SECONDS_REMAINING)
    @started = false
    @seconds_remaining = remaining.seconds
  end

  def start
    raise(TimerError, "cannot start the timer. it is already running") if started?
    @deadline = Time.now + @seconds_remaing
    @started = true
  end

  def stop
    raise(TimerError, "cannot stop the timer. it is not running") unless started?
    @started = false
    @seconds_remaining = (@deadline - Time.now)
  end

  def triggered?
    deadline < Time.now
  end

  def deadline
    @deadline
  end

  def reset(remaining = SECONDS_REMAINING)
    @seconds_remaining = remaining.seconds
    @deadline = Time.now + @seconds_remaining
  end

  def started?
    @started
  end
end
