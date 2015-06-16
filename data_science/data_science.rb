require_relative './data_analyzer'

require 'json'

class DataScience
  DATAFILE = 'data_export_2014_06_20_15_59_02.json'

  def initialize
    @analysis = DataAnalyzer.new(data)
    puts "\n"
    display_cohort_info
    display_cohort_conversion
    display_confidence
  end

  private

  def display_cohort_info
    print_cohort_info("A")
    print_cohort_info("B")
    puts "\n"
  end

  def display_cohort_conversion
    print_conversion_rate("A")
    print_conversion_rate("B")
    puts "\n"
  end

  def display_confidence
    puts "Confidence that results are conclusive: #{@analysis.conclusive?}\n\n"
  end

  def print_conversion_rate(cohort)
    conversion = @analysis.conversion_rate(cohort)
    print "Cohort #{cohort} conversion rate: "
    print "#{(conversion[:rate] * 100).to_i}% "
    puts "+/- #{(conversion[:deviation] * 100).to_i}"
  end

  def print_cohort_info(cohort)
    print "Cohort #{cohort} sample size: "
    puts @analysis.sample_size(cohort)
    print "Cohort #{cohort} number of conversions: "
    puts @analysis.num_conversions(cohort)
  end

  def data
    contents = File.read(absolute_path(DATAFILE))
    dataset = JSON.parse(contents)
    dataset.map { |hash| Hash[hash.map { |k, v| [k.to_sym, v] }] }
  end

  def absolute_path(path)
    File.expand_path(File.dirname(__FILE__)) + '/' + path
  end
end

DataScience.new