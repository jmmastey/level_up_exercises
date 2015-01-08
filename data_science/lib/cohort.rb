
class Cohort
  attr_reader :cohort, :conversions, :nonconvs
  def initialize(cohort_name, conversions, nonconvs)
    @cohort_name = cohort_name
    @conversions = conversions
    @nonconvs = nonconvs
  end

  def total_trials
    @conversions + @nonconvs
  end

  def conversion_rate
    @conversions.to_f / total_trials
  end

  def standard_error
    sqrt(conversion_rate * (1 - conversion_rate) / total_trials)
  end

  def conversion_range
    Range.new(
      conversion_rate - 1.96 * standard_error,
      conversion_rate + 1.96 * standard_error)
  end
end
