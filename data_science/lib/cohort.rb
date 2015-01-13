include Math

class Cohort
  attr_reader :conversions, :nonconvs
  def initialize(conversions, nonconvs)
    raise ArgumentError if conversions < 0 || nonconvs < 0
    raise ArgumentError unless (conversions + nonconvs) > 0
    raise TypeError unless conversions.is_a?(Integer) && nonconvs.is_a?(Integer)
    @conversions = conversions
    @nonconvs = nonconvs
  end

  def total_trials
    @conversions + @nonconvs
  end

  def conversion_rate
    (@conversions.to_f / total_trials).round(6)
  end

  def standard_error
    (sqrt(conversion_rate * (1 - conversion_rate) / total_trials)).round(6)
  end

  def conversion_range
    Range.new(
      (conversion_rate - 1.96 * standard_error).round(6),
      (conversion_rate + 1.96 * standard_error).round(6))
  end

  def to_h
    {
      conversions: @conversions,
      nonconvs: @nonconvs,
    }
  end
end
