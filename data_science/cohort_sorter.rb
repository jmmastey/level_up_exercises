require_relative 'cohort'

class CohortSorter
  attr_accessor :visits, :cohorts, :cohort_groups

  def initialize(visits)
    @visits = visits
    @cohorts = cohorts
    @cohort_groups = cohort_groups
  end

  def cohorts
    sorted_visits_by_cohort.inject({}) do |hash, cohort|
      hash[cohort[0]] = Cohort.new(cohort[1])
      hash
    end
  end

  def success_failures
    cohorts.inject({}) do |hash, cohort|
      hash[cohort[0]] = {
        success: cohort[1].conversions,
        failure: cohort[1].failures,
      }
      hash
    end
  end

  def sorted_cohorts_by_conversion
    to_a.sort_by(&:conversion_percentage)
  end

  def sorted_visits_by_cohort
    cohort_groups.inject({}) do |hash, cohort|
      hash[cohort.to_sym] = all_visits_by_cohort(cohort)
      hash
    end
  end

  def all_visits_by_cohort(cohort)
    visits.find_all { |visit| visit['cohort'] == cohort }
  end

  def cohort_groups
    visits.map { |visit| visit['cohort'] }.uniq
  end

  def to_a
    cohorts.map { |cohort| cohort[1] }
  end
end
