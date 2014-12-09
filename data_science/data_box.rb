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

  def cohorts
    cohorts_names = @data.map { |result| result["cohort"] }.uniq
    cohorts = []
    cohorts_names.each do |cohort_name|
      cohort_data = @data.select { |result| result["cohort"] == cohort_name }
      cohorts.push(Cohort.new(cohort_data, cohort_name))
    end
    cohorts
  end

  def populate_groups_hash(groups)
    cohorts.each do |cohort|
      clicks = cohort.conversions
      size = cohort.size
      groups[cohort] = { success: clicks, failure: (size - clicks) }
    end
  end

  def cohort_probabilities
    groups = {}
    populate_groups_hash(groups)
    ABAnalyzer::ABTest.new(groups).chisquare_p
  end

  def winning_cohort
    sorted_conversion_rates.to_a.last.first
  end

  def winner
    if cohort_probabilities >= PROBABILITY_THRESHOLD
      "No clear winner"
    else
      "Winner: Cohort #{winning_cohort.name}"
    end
  end

  private

  def sorted_conversion_rates
    percentages = {}
    cohorts.each do |cohort|
      percentages[cohort] = cohort.conversion_percentage
    end
    Hash[percentages.sort_by { |_, percent| percent }]
  end
end
