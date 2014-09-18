require 'abanalyzer'

class Cohort
  attr_accessor :samples, :name

  def initialize
    @samples = []
  end

  def sample_size
    samples.length
  end

  def conversion_count
    samples.count { |x| x["result"] == 1 }
  end

  def conversion_rate
    return 0.to_f if sample_size == 0
    conversion_count.to_f / sample_size.to_f
  end

  def confidence_interval(level)
    ABAnalyzer.confidence_interval(conversion_count, sample_size, level)
  end

  private

  def sample_variance
    sum_conversions = conversion_count * (1 - conversion_rate)**2
    sum_non_conversions = (sample_size - conversion_count) * conversion_rate**2
    (sum_conversions + sum_non_conversions)/(sample_size - 1).to_f
  end

  def standard_deviation
    Math.sqrt(sample_variance)
  end

  def standard_error
    standard_deviation / Math.sqrt(sample_size)
  end
end
