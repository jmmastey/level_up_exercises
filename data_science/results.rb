require "hirb"
require_relative "json_parser"
require_relative "dataset"


class Results
  extend Hirb::Console

  ROUND_TO = 4

  json = JSONParser.new("source_data.json")
  @dataset = Dataset.new(json.fetch_data)

  def self.cohorts_table
    table cohort_results,
      headers: ["Groups", "Sample Size", "Conversions", "Per. of Conversions"],
      description: false
  end

  def self.cohort_results
    @dataset.all_group_types.map do |cohort|
      [cohort,
       @dataset.total_in_group(cohort),
       @dataset.number_of_conversions(cohort),
       percentage_by_cohort(cohort)]
    end
  end

  def self.percentage_by_cohort(cohort)
    pct_con = (@dataset.cohort_percentages[cohort] * 100).round(ROUND_TO)
    std_err = (@dataset.calculate_standard_error(cohort) * 100).round(ROUND_TO)

    "Group #{cohort}: #{pct_con}%" \
      " +/- #{std_err}% (#{pct_con - std_err}% - #{pct_con + std_err}%)"
  end

  def self.total_sample_size
    "Total Sample Size: #{@dataset.total_sample_size}"
  end

  def self.confidence_level
    "Confidence Level: #{@dataset.calculate_group_probabilities.round(ROUND_TO)}"
  end

  def self.winner
    @dataset.show_winner
  end
end
