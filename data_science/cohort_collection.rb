require_relative 'cohort.rb'

class CohortCollection
  attr_accessor :cohorts

  def initialize(cohorts)
    @cohorts = Array(cohorts)
  end

  def sum
    cohorts.inject(0) { |a, cohort| a + cohort.size }
  end

  def sum_failures
    cohorts.inject(0) { |a, cohort| a + cohort.failures }
  end

  def sum_successes
    cohorts.inject(0) { |a, cohort| a + cohort.successes }
  end

  def chi_squared
    cohorts.inject(0) do |a, cohort|
      a + chi_squared_for_success(cohort) + chi_squared_for_failure(cohort)
    end
  end

  def leader
    cohorts.sort_by(&:success_ratio).last.name
  end

  def to_s
    cohorts.map(&:to_s).join("\n")
  end

  private

  def chi_squared_for_success(cohort)
    expected = (cohort.size * sum_successes).to_f / sum
    (cohort.successes - expected)**2 / expected
  end

  def chi_squared_for_failure(cohort)
    expected = (cohort.size * sum_failures).to_f / sum
    (cohort.failures - expected)**2  / expected
  end
end
