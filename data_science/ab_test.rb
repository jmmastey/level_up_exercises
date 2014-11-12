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

  RESULTS = [:success, :failure]
  SEPARATOR = '-' * 100

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

  def significant?(confidence = 0.90)
    raise ArgumentError unless CONFIDENCE_LEVEL_CUTOFFS.key?(confidence)
    chi_squared > CONFIDENCE_LEVEL_CUTOFFS[confidence]
  end

  def to_s
    SEPARATOR + "\n" +
    @cohorts.sort_by(&:name).map(&:to_s).join("\n") + "\n" +
    SEPARATOR + "\n" +
    decision + "\n"
  end

  private

  def valid_matrix?(matrix)
    return false unless matrix.is_a?(Hash)

    matrix.all? do |_, row|
      row.all? do |col_key, col|
        RESULTS.include?(col_key) && col.is_a?(Numeric)
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
      RESULTS.inject(a) do |b, result|
        b + chi_squared_component(cohort.name, result, cohort[result])
      end
    end
  end

  def leader
    @cohorts.sort_by(&:success_ratio).last
  end

  def decision(threshold = 0.90)
    if significant?(threshold)
      "Leader is #{leader.name} at #{confidence_level * 100}% confidence level"
    else
      "No clear leader at #{threshold * 100}% confidence level"
    end
  end
end
