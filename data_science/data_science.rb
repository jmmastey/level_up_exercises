require_relative "json_parser"
require_relative "cohort"

class DataScience
  include JsonParser
  attr_accessor :cohorts, :ab_analyzer

  def initialize(input_file = "source_data.json")
    data = read(input_file)
    @cohorts = extract_cohorts(data)
    @ab_analyzer = ABAnalyzer::ABTest.new(ab_formatted)
    display_results
  end

  def better_than_random
    safe_chisquare_p < 0.05
  end

  def safe_chisquare_p
    @ab_analyzer.chisquare_p
  # check this in spec
  #raise ABAnalyzer::InsufficientDataError
  #  100.0
  end

  def leader_name
    @cohorts.max { |a, b| a[1].conversion_rate <=> b[1].conversion_rate }[0]
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
    display_header
    display_cohorts
    display_summary
  end

  def display_cohorts
    sorted = @cohorts.to_a.sort_by { |element| element[0] }
    sorted.each do |element|
      puts cohort_line(element[0], element[1])
    end
  end

  def display_header
    puts "Cohort  Samples  Conversions  Rate      Confidence Interval"
  end

  COHORT_FORMAT = "%-6.6s  %-8.0d %-9.0d %7.1f%%     %0.1f%% to %0.1f%%"

  def cohort_line(name, cohort)
    sprintf(COHORT_FORMAT,
            name,
            cohort.sample_size,
            cohort.conversion_count,
            cohort.conversion_rate * 100,
            cohort.confidence_interval(0.95)[0] * 100,
            cohort.confidence_interval(0.95)[1] * 100)
  end

  def display_summary
    puts sprintf("\np value = %0.3f", safe_chisquare_p)
    text = better_than_random ? "" : " not"
    puts "The leader (#{leader_name}) is#{text} better than random."
  end
end

