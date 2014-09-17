require "thread"

class TimerError < RuntimeError; end

class BombTimer
  SECONDS_REMAINING = 30
  attr_reader :seconds_left

  def initialize(seconds_remaining = SECONDS_REMAINING)
    @started = false
    @seconds_remaining = seconds_remaining
    @last_time_checked = nil
  end

  def start(time)
    raise(TimerError, "cannot start the timer. it is already running") if started?
    @last_time_checked = time
    @started = true
  end

  def stop(time)
    raise(TimerError, "cannot stop the timer. it is not running") unless started?
    update_seconds_remaining(time)
    @started = false
  end

  def triggered?(time)
    if started?
      update_seconds_remaining(time)
    end
    @seconds_remaining <= 0
  end

  def reset(time, seconds_remaining = SECONDS_REMAINING)
    @seconds_remaining = seconds_remaining
    @last_time_checked = time
  end

  def started?
    @started
  end

  private

  def update_seconds_remaining(time)
    @seconds_remaining -= (time - @last_time_checked)
    @last_time_checked = time
  end
end
