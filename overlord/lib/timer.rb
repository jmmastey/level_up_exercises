class Timer
  attr_reader :duration, :end_time, :start_time

  def initialize(duration)
    @start_time = Time.now
    @duration = duration
    @end_time = @start_time + duration
  end

  def active?
    Time.now < @end_time
  end

  def expired?
    Time.now >= @end_time
  end
end
