require_relative 'cohort'

InvalidABMatrixError = Class.new(StandardError)

class ABTest
  CONFIDENCE_LEVEL_CUTOFFS = {
    0.995 => 7.879,
    0.99 => 6.635,
    0.975 => 5.024,
    0.95 => 3.841,
    0.90 => 2.706,
  }

  def initialize(matrix)
    raise InvalidABMatrixError unless valid_matrix?(matrix)
    @cohort_totals = {}
    @result_totals = {}
    @cohorts =  matrix.map { |name, data| create_cohort(name, data) }
  end

  def chi_squared
    @chi_squared ||= calculate_chi_squared
  end

  def confidence_level
    return nil unless significant?(0.90)
    CONFIDENCE_LEVEL_CUTOFFS.find { |_, v| v < chi_squared }.first
  end

  def significant?(confidence_level = 0.90)
    chi_squared > CONFIDENCE_LEVEL_CUTOFFS[confidence_level]
  end

  private

  def valid_matrix?(matrix)
    return false unless matrix.is_a?(Hash)

    matrix.all? do |_, row|
      row.all? do |col_key, col|
        [:success, :failure].include?(col_key) && col.is_a?(Numeric)
      end
    end
  end

  def create_cohort(name, data)
    Cohort.new(name).tap do |cohort|
      cohort.add_successes(data[:success])
      cohort.add_failures(data[:failure])
    end
  end

  def grand_total
    @grand_total ||= calculate_grand_total
  end

  def cohort_total(cohort_name)
    @cohort_totals[cohort_name] ||= calculate_cohort_total(cohort_name)
  end

  def result_total(result)
    @result_totals[result] ||= calculate_result_total(result)
  end

  def calculate_grand_total
    @cohorts.inject(0) { |a, cohort| a + cohort.size }
  end

  def calculate_cohort_total(cohort_name)
    @cohorts.select { |cohort| cohort.name == cohort_name }
      .inject(0) { |a, cohort| a + cohort.size }
  end

  def calculate_result_total(result)
    @cohorts.inject(0) { |a, cohort| a + cohort[result] }
  end

  def expected(cohort_name, result)
    (cohort_total(cohort_name) * result_total(result)).to_f / grand_total
  end

  def chi_squared_component(cohort_name, result, observed)
    expected = expected(cohort_name, result)
    ((observed - expected)**2.to_f) / expected
  end

  def calculate_chi_squared
    @cohorts.inject(0) do |a, cohort|
      [:success, :failure].inject(a) do |b, result|
        b + chi_squared_component(cohort.name, result, cohort[result])
      end
    end
  end
end
