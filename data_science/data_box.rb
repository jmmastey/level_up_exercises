require 'abanalyzer'
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

  def size_of_cohort(cohort)
    @data.count { |result| result["cohort"] == cohort }
  end

  def conversions(cohort)
    @data.count do |result|
      result["cohort"] == cohort && result["result"] == 1
    end
  end

  def conversion_percentage(cohort)
    conversions(cohort).to_f / size_of_cohort(cohort).to_f
  end

  def standard_error(cohort)
    p = conversion_percentage(cohort)
    n = size_of_cohort(cohort)
    (Math.sqrt(p * (1 - p) / n))
  end

  def cohorts
    @data.map { |result| result["cohort"] }.uniq
  end

  def populate_groups_hash(groups)
    cohorts.each do |cohort|
      clicks = conversions(cohort)
      size = size_of_cohort(cohort)
      groups[cohort] = { success: clicks, failure: (size - clicks) }
    end
  end

  def cohort_probabilities
    groups = {}
    populate_groups_hash(groups)
    ABAnalyzer::ABTest.new(groups).chisquare_p
  end

  def sorted_conversion_rates
    percentages = {}
    cohorts.each do |cohort|
      percentages[cohort] = conversion_percentage(cohort)
    end
    Hash[percentages.sort_by { |_, percent| percent }]
  end

  def winning_cohort
    sorted_conversion_rates.to_a.last.first
  end

  def show_winner
    if cohort_probabilities >= PROBABILITY_THRESHOLD
      "No clear winner"
    else
      "Winner: Cohort #{winning_cohort}"
    end
  end
end
