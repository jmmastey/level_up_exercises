require "json_reader"
require "cohort"

class DataScience
  include JsonReader
  attr_accessor :cohorts, :ab_analyzer

  def initialize(input_file = "source_data.json")
    process_file(input_file)
  end

  def leader_is_better_than_random
    # puts sprintf("%0.5f", @ab_analyzer.chisquare_p)
    # puts sprintf("%0.5f", @ab_analyzer.chisquare_score)
    @ab_analyzer.chisquare_p < 0.05
  end

  private

  def process_file(input_file)
    data = read(input_file)
    @cohorts = extract_cohorts(data)
    @ab_analyzer = analyze(@cohorts)
  end

  def extract_cohorts(data)
    data.inject({}) do |result, element|
      result[element["cohort"]] ||= Cohort.new
      result[element["cohort"]].samples.push(element)
      result
    end
  end

  def analyze(values)
    ABAnalyzer::ABTest.new(ab_formatted(values))
  end

  def ab_formatted(cohorts)
    values = {}
    cohorts.each do |name, cohort|
      values[name] = { :conversion_count => cohort.conversion_count,
                       :sample_size      => cohort.sample_size }
    end
    values
  end
end
