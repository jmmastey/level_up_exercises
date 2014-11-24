require 'abanalyzer'

class Cohort
  CONFIDENCE_LEVEL = 0.95
  attr_reader :visitors

  # Splat is for variable length args, not array?
  def initialize(visitors=[])
    @visitors = visitors
  end

  def sample_size
    @visitors.length
  end

  def add(visitors)
    @visitors += Array(visitors)
    self
  end

  def conversions
    @visitors.count { |visitor| visitor.result == 1 }
  end

  def conversion_percentage
    return 0 unless sample_size > 0
    conversions.to_f / sample_size.to_f
  end

  def confidence_interval
    ABAnalyzer.confidence_interval(conversions, sample_size, CONFIDENCE_LEVEL)
  end
end
