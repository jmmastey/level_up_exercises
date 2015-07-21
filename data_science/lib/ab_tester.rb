require 'abanalyzer'

class ABTester
  attr_accessor :all_visits

  def initialize(all_visits)
    @all_visits = all_visits
  end

  def conversion_rate(visits)
    conversions(visits) / visits.size.to_f
  end

  def cohort_by_name(cohort_name)
    all_visits.select { |visit| visit["cohort"] == cohort_name }
  end

  def conversions(visits)
    visits.count { |visit|  visit["result"] == 1 }
  end

  def chi_square(cohort_a, cohort_b)
    values = {}
    values[:cohort_a] = create_values_for_chi_square(cohort_a)
    values[:cohort_b] = create_values_for_chi_square(cohort_b)
    tester = ABAnalyzer::ABTest.new values
    (1 - tester.chisquare_p) * 100
  end

  def create_values_for_chi_square(visits)
    {
      result_0: visits.size - conversions(visits),
      result_1: conversions(visits),
    }
  end
end
