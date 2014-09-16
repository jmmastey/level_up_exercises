require_relative "cohort"

class ChiSquare
  attr_reader :cohorts, :sig_level, :statistic

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

  private

  def valid_input?(cohorts)
    cohorts.count == 2 && cohorts[0].is_a?(Cohort) && cohorts[1].is_a?(Cohort)
  end
end
