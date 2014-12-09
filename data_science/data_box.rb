require 'abanalyzer'
require_relative 'cohort'

class DataBox
  # 1.96 is a confidence level of approx. 95%
  CONFIDENCE_LEVEL = 1.96
  PROBABILITY_THRESHOLD = 0.05

  def initialize(data)
    @data = data
  end

  def sample_size
    @data.length
  end

  def winner_significance
    groups = build_groups
    ABAnalyzer::ABTest.new(groups).chisquare_p
  end

  def winner
    if winner_significance >= PROBABILITY_THRESHOLD
      "No clear winner"
    else
      "Winner: Cohort #{winning_cohort.name}"
    end
  end

  private

  def sorted_conversion_rates
    cohorts.sort_by { |cohort| cohort.conversion_percentage }
  end

  def build_groups
    groups = {}
    cohorts.each do |cohort|
      clicks = cohort.conversions
      size = cohort.size
      groups[cohort] = { success: clicks, failure: (size - clicks) }
    end
    groups
  end

  def cohorts
    cohorts_names = @data.map { |result| result["cohort"] }.uniq
    cohorts_names.map do |cohort_name|
      cohort_data = @data.select { |result| result["cohort"] == cohort_name }
      Cohort.new(cohort_data, cohort_name)
    end
  end

  def winning_cohort
    sorted_conversion_rates.to_a.last
  end
end
