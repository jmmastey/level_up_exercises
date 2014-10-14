# Runner for the Data Science exercise
require_relative "json_loader"
require_relative "dataset"

class Results
  ROUND_TO = 4

  json = JSONLoader.new("source_data.json")
  @dataset = Dataset.new(json.fetch_data)
  @cohorts = @dataset.all_group_types

  def self.total_sample_size
    "Total Sample Size: #{@dataset.total_sample_size}"
  end

  # TODO: condense cohort outputs to one line per cohort
  def self.cohort_sample_size
    output = ["Sample Size"]
    @cohorts.map do |cohort|
      total = @dataset.total_in_group(cohort)
      output << "\tGroup #{cohort}: #{total}"
    end

    output.join("\n")
  end

  def self.conversions
    output = ["Conversions"]
    @cohorts.map do |cohort|
      conversions = @dataset.number_of_conversions(cohort)
      output << "\tGroup #{cohort}: #{conversions}"
    end

    output.join("\n")
  end

  def self.percentage_of_conversions
    output = ["Percentage of Conversions"]
    percents = @dataset.cohort_percentages

    @cohorts.map do |cohort|
      output << "\t#{percentage_by_cohort(cohort, percents)}"
    end

    output.join("\n")
  end

  # TODO: remove percents, round before calcs
  def self.percentage_by_cohort(cohort, percents)
    pct_con = percents[cohort] * 100
    std_err = @dataset.calculate_standard_error(cohort) * 100

    "Group #{cohort}: #{pct_con.round(ROUND_TO)}%" \
      " +/- #{std_err.round(ROUND_TO)}%" \
      " (#{(pct_con - std_err).round(ROUND_TO)}% -" \
      " #{(pct_con + std_err).round(ROUND_TO)}%)"
  end

  def self.confidence_level
    "Confidence Level: #{@dataset.calculate_probability.round(ROUND_TO)}"
  end

  def self.winner
    if @dataset.calculate_probability >= Dataset::PROBABILITY_THRESHOLD
      "No clear winner"
    else
      "Cohort #{@dataset.cohort_percentages.to_a.last.first} is the winner"
    end
  end

  def self.show_results
    output = []
    output << total_sample_size
    output << cohort_sample_size
    output << conversions
    output << percentage_of_conversions
    output << confidence_level
    output << winner
    output.join("\n")
  end
end

puts Results.show_results
