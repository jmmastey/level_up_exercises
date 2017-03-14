require 'abanalyzer'
class ABtest
  attr_reader :cohort_a
  attr_reader :cohort_b
  attr_reader :leader

  def initialize(cohort_a, cohort_b)
    @cohort_a = cohort_a
    @cohort_b = cohort_b
    @leader = find_leader
  end

  def compute_leader_confidence_level
    sample_data = {}
    sample_data[@cohort_a.name] = { failures: compute_failures(@cohort_a),
                                    successes: @cohort_a.num_conversions }
    sample_data[@cohort_b.name] = { failures: compute_failures(@cohort_b),
                                    successes: @cohort_b.num_conversions }
    compare_cohorts = ABAnalyzer::ABTest.new(sample_data)
    1.0 - compare_cohorts.chisquare_p
  end

  private

  def find_leader
    return @cohort_a.name if @cohort_a.conversion_rate > @cohort_b.conversion_rate
    return @cohort_b.name if @cohort_b.conversion_rate > @cohort_a.conversion_rate
    return nil if @cohort_a.conversion_rate == @cohort_b.conversion_rate
  end

  def compute_failures(cohort)
    cohort.sample_size - cohort.num_conversions
  end
end
