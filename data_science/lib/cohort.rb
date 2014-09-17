require 'abanalyzer'

class Cohort
  attr_accessor :samples

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
    conversion_count.to_f / sample_size.to_f
  end

  def confidence_interval(percent)
    params = [conversion_count, sample_size, percent]
    round_values(ABAnalyzer.confidence_interval(*params))
  end

  private

  def round_values(array)
    array.map! {|item| item.round(3)}
  end

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
