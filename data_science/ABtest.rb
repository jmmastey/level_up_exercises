require 'abanalyzer'
class ABtest

  attr_accessor :cohort_A
  attr_accessor :cohort_B
  attr_accessor :leader

  def initialize(cohort_A, cohort_B)
    @cohort_A = cohort_A
    @cohort_B = cohort_B
    @leader = find_leader
  end

  def find_leader
    return @cohort_A.name if @cohort_A.conversion_rate > @cohort_B.conversion_rate
    return @cohort_B.name if @cohort_B.conversion_rate > @cohort_A.conversion_rate
    return nil if @cohort_A.conversion_rate == @cohort_B.conversion_rate
  end

  def compute_leader_confidence_level
    sample_data = {}
    sample_data[@cohort_A.name] = {:failures => compute_failures(@cohort_A), 
                                   :successes => @cohort_A.num_conversions }
    sample_data[@cohort_B.name] = {:failures => compute_failures(@cohort_B), 
                                   :successes => @cohort_B.num_conversions}
    compare_cohorts = ABAnalyzer::ABTest.new(sample_data)
    return 1.0 - compare_cohorts.chisquare_p
  end

  private 
  def compute_failures(cohort)
   cohort.sample_size - cohort.num_conversions
  end

end
