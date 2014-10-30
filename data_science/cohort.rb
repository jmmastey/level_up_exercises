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
    return 0.to_f if sample_size == 0
    conversion_count.to_f / sample_size.to_f
  end

  def confidence_interval(level)
    ABAnalyzer.confidence_interval(conversion_count, sample_size, level)
  end
end
