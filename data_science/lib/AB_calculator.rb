require 'json'
require 'abanalyzer'
require_relative 'cohort'
include Math

class ABCalculator
  def initialize(a_b_data)
    @a_cohort = Cohort.new("A", a_b_data[:a][:pass], a_b_data[:a][:fail])
    @b_cohort = Cohort.new("B", a_b_data[:b][:pass], a_b_data[:b][:fail])
    @a_b_tester = ABAnalyzer::ABTest.new(a_b_data)
  end

  def sample_size
    {
      a: @a_cohort.total,
      b: @b_cohort.total,
    }
  end

  def conversion_rate
    {
      a: @a_cohort.conversion_rate,
      b: @b_cohort.conversion_rate,
    }
  end

  def conversion_range
    {
      a: @a_cohort.conversion_range,
      b: @b_cohort.conversion_range,
    }
  end

  def confidence_level
    1 - chi_square_p_value
  end

  private

  def standard_error
    {
      a: @a_cohort.standard_error,
      b: @b_cohort.standard_error,
    }
  end

  def chi_square_p_value
    @a_b_tester.chisquare_p
  end
end
