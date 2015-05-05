require 'abanalyzer'
class ABCompare
  attr_reader :cohort_a
  attr_reader :cohort_b

  def initialize(cohort_a, cohort_b)
    @cohort_a = cohort_a
    @cohort_b = cohort_b
  end

  def compute_leader_confidence_level
    sample_data = [@cohort_a, @cohort_b].each_with_object({}) do |cohort, sample_data| 
      sample_data[cohort.name] = {failures: cohort.compute_failures, 
                                  successes: cohort.num_conversions }
    end
    compare_cohorts = ABAnalyzer::ABTest.new(sample_data)
    1.0 - compare_cohorts.chisquare_p
  end

  def leader
    return @cohort_a.name if @cohort_a.conversion_rate > @cohort_b.conversion_rate
    return @cohort_b.name if @cohort_b.conversion_rate > @cohort_a.conversion_rate
    return nil if @cohort_a.conversion_rate == @cohort_b.conversion_rate
  end

end
