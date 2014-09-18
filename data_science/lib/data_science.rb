require "json_reader"
require "cohort"

class DataScience
  include JsonReader
  attr_accessor :cohorts

  def initialize(input_file = "source_data.json")
    process_file(input_file)
  end

  def leader_is_better_than_random
    values = {}
    cohorts.each do |name, cohort|
      values[name] = { :conversion_count => cohort.conversion_count * 500,
                       :sample_size      => cohort.sample_size * 500 }
    end
    tester = ABAnalyzer::ABTest.new(values)
    puts sprintf("%0.5f", tester.chisquare_p)
    puts sprintf("%0.5f", tester.chisquare_score)
    tester.chisquare_p < 0.05
  end

  private

  def process_file(input_file)
    data = read(input_file)
    extract_cohorts(data)
  end

  def extract_cohorts(data)
    @cohorts = {}
    data.each do |item|
      @cohorts[item["cohort"]] ||= Cohort.new
      @cohorts[item["cohort"]].samples.push(item)
    end
  end
end
