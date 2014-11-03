require 'abanalyzer'

class Dataset
  CONFIDENCE_LEVEL = 1.96
  PROBABILITY_THRESHOLD = 0.05

  def initialize(data)
    @results = data
  end

  def total_sample_size
    @results.length
  end

  def total_in_group(cohort)
    @results.count { |result| result["cohort"] == cohort }
  end

  def number_of_conversions(cohort)
    @results.count { |result| result["cohort"] == cohort && result["result"] == 1 }
  end

  def percentage_of_conversion(cohort)
    number_of_conversions(cohort).to_f / total_in_group(cohort).to_f
  end

  def calculate_standard_error(cohort)
    p = percentage_of_conversion(cohort)
    n = total_in_group(cohort)

    ((Math.sqrt(p * (1 - p) / n)) * CONFIDENCE_LEVEL)
  end

  def all_group_types
    @results.map { |result| result["cohort"] }.uniq
  end

  def calculate_group_probabilities
    groups = {}

    all_group_types.each do |group|
      clicks = number_of_conversions(group)
      total = total_in_group(group)

      groups[group] = { success: clicks, failure: (total - clicks) }
    end

    ABAnalyzer::ABTest.new(groups).chisquare_p
  end

  def cohort_percentages
    percentages = {}

    all_group_types.each do |group|
      percentages[group] = percentage_of_conversion(group)
    end

    Hash[percentages.sort_by { |_, percent| percent }]
  end

  def show_winner
    if calculate_group_probabilities >= PROBABILITY_THRESHOLD
      "No clear winner"
    else
      "Cohort #{cohort_percentages.to_a.last.first} is the winner"
    end
  end
end
