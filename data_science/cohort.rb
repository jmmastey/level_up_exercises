# This class is used to define errors for invalid cohorts
class InvalidCohortError < RuntimeError
  def message
    'This cohort does not contain results of 0 or 1 so it is invalid'
  end
end
# The cohort class is responsible for the conversion rate and error bars
class Cohort
  attr_accessor :conversions, :nonconversions
  CONV_FACTOR = 0.95
  def initialize
    @conversions = 0
    @nonconversions = 0
    @cohort_visits = 0
  end

  def total_cohort_visits
    @cohort_visits  = @conversions + @nonconversions
    @cohort_visits
  end

  def error_bars
    ABAnalyzer.confidence_interval(@conversions, total_cohort_visits, CONV_FACTOR)
  end

  def conversion_rate
    rate = @conversions.to_f / total_cohort_visits.to_f
    rate
  end

  def calc_conversion_nonconversion(result)
    raise InvalidCohortError unless [0, 1].include?(result)
    @conversions += 1   if result == 1
    @nonconversions += 1 if result == 0
  end
end
