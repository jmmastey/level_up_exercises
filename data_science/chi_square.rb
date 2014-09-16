require_relative "cohort"

class ChiSquare
  attr_reader :cohorts, :sig_level, :statistic, :value

  STATISTICS = {
    0.50  =>  0.455,
    0.10  =>  2.706,
    0.05  =>  3.841,
    0.02  =>  5.412,
    0.01  =>  6.635,
    0.001 => 10.827
  }

  def initialize(cohorts, options = {})
    raise ArgumentError unless valid_input?(cohorts)
    @cohorts = cohorts
    @sig_level = options[:sig_level] || 0.05
  end

  def statistic
    STATISTICS[sig_level]
  end

  def value
    a_c = cohorts[0].conversions.to_f
    a_n = cohorts[0].non_conversions.to_f
    b_c = cohorts[1].conversions.to_f
    b_n = cohorts[1].non_conversions.to_f


    numerator = (a_n * b_c - a_c * b_n)**2 * (a_c + a_n + b_c + b_n)
    denominator = (a_c + a_n) * (b_c + b_n) * (a_c + b_c) * (a_n + b_n)
    numerator / denominator
  end

  def statistically_significant?
    value > statistic
  end

  private

  def valid_input?(cohorts)
    cohorts.count == 2 && cohorts[0].is_a?(Cohort) && cohorts[1].is_a?(Cohort)
  end
end
