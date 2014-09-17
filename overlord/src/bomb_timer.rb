require "thread"

class TimerError < RuntimeError; end

class BombTimer
  DEFAULT_SECONDS = 30
  attr_reader :elapsed_seconds

  def initialize(seconds = DEFAULT_SECONDS)
    @lock = Mutex.new
    @active = false
    @seconds = seconds
    @elapsed_seconds = 0
    @last_time_measured = nil
    @times_up_handlers = []
    @counter = counter
  end

  def start
    @lock.synchronize do
      raise(TimerError, "timer is already started") if @active
      @active = true
    end
  end

  def stop
    @lock.synchronize do
      raise(TimerError, "timer is already stopped") unless @active
      @active = false
    end
  end

  def reset(seconds = DEFAULT_SECONDS)
    @lock.synchronize do
      @elapsed_seconds = 0
      @seconds = seconds
    end
  end

  def on_times_up(handler)
    @times_up_handlers << handler
  end

  private

  def run_times_up_handlers
    @times_up_handlers.each { |handler| handler.call }
  end

  def counter
    Thread.new do
      while @elapsed_seconds <= @seconds
        sleep(0.01)
        if @active
          current_time = Time.now
          last_time_measured = current_time if last_time_measured.nil?
          @elapsed_seconds += (current_time - last_time_measured)
          last_time_measured = current_time
        end
      end
      run_times_up_handlers
    end
  end
end
