class Cohort
  attr_reader :name
  attr_accessor :successes, :failures

  def initialize(name)
    raise ArgumentError unless name.is_a? String
    @name      = name
    @successes = 0
    @failures  = 0
  end

  def size
    @successes + @failures
  end

  def success_ratio
    return 0.00 if size == 0
    @successes.to_f / size
  end

  def standard_error
    return 0.00 if size == 0
    Math.sqrt(success_ratio * (1 - success_ratio) / size)
  end

  def confidence_interval
    sigmas = 1.96 * standard_error
    [success_ratio - sigmas, success_ratio + sigmas]
  end

  def to_s
    return "This cohort does not contain any results" if size == 0

    format("%s | No. of Samples: %5d, success_ratio: %3.2f%%, 95%% confidence interval: %s",
      name, size, success_ratio * 100, confidence_interval_human_readable)
  end

  private

  def confidence_interval_human_readable
    lower, upper = confidence_interval.map { |i| format("%3.2f\%", (i * 100)) }
    "(#{lower} - #{upper})"
  end
end
