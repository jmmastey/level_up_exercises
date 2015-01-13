include Math

class ABCohort
  attr_reader :cohort, :conversions, :nonconvs
  def initialize(cohort_name, conversions, nonconvs)
    raise "Invalid cohort name" unless cohort_name == "A" || cohort_name == "B"
    raise "Invalid data" if conversions < 0 || nonconvs < 0
    raise "Need at least one trial" unless (conversions + nonconvs) > 0
    @cohort_name = cohort_name
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
      nonconvs: @nonconvs
    }
  end
end
