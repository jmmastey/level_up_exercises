require_relative "json_reader"
require_relative "cohort"

class DataScience
  include JsonReader
  attr_accessor :cohorts, :ab_analyzer

  def initialize(input_file = "source_data.json")
    data = read(input_file)
    @cohorts = extract_cohorts(data)
    @ab_analyzer = ABAnalyzer::ABTest.new(ab_formatted)
    display_results
  end

  def leader_is_better_than_random
    @ab_analyzer.chisquare_p < 0.05
  rescue ABAnalyzer::InsufficientDataError => error
    puts error.message
  end

  def safe_chisquare_p
    @ab_analyzer.chisquare_p
  rescue ABAnalyzer::InsufficientDataError => error
    puts error.message
    100.0
  end

  private

  def extract_cohorts(data)
    data.inject({}) do |result, element|
      result[element["cohort"]] ||= Cohort.new
      result[element["cohort"]].samples.push(element)
      result
    end
  end

  def ab_formatted
    values = {}
    @cohorts.each do |name, cohort|
      values[name] = {  conversion_count: cohort.conversion_count,
                        sample_size: cohort.sample_size }
    end
    values
  end

  def display_results
    sorted = @cohorts.to_a.sort_by { |element| element[0] }

    puts "Cohort  Samples  Conversions  Rate      Confidence Interval"
    sorted.each do |element|
      cohort = element[1]
      puts sprintf("%-6.6s  %-8.0d %-9.0d %7.1f%%     %0.1f%% to %0.1f%%",
                   element[0],
                   cohort.sample_size,
                   cohort.conversion_count,
                   cohort.conversion_rate * 100,
                   cohort.confidence_interval(0.95)[0] * 100,
                   cohort.confidence_interval(0.95)[1] * 100
      )
    end

    puts sprintf("p value = %0.3f", safe_chisquare_p)
    print "\nis the leader better than random? "
  end
end
