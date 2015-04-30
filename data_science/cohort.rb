CohortNameError = Class.new(RuntimeError)

class Cohort
  attr_reader :name
  attr_reader :sample_size
  attr_reader :num_conversions
  attr_reader :conversion_rate

  def initialize(name, sample_size, num_conversions)
    @name = name
    @sample_size = sample_size
    @num_conversions = num_conversions
    @conversion_rate = @num_conversions.to_f / @sample_size
  end

  def confidence_interval_95pct
    interval = std_dev * 1.96
    [@conversion_rate - interval, @conversion_rate + interval]
  end

  def std_dev
    Math.sqrt(@conversion_rate * (1 - @conversion_rate) / @sample_size)
  end

  def compute_failures
    @sample_size - @num_conversions
  end
end
