require './website_data'
require './website_stats'
require './data_from_file'
require 'abanalyzer'

class DataScience
  attr_accessor :stats

  def initialize(data)
    @stats = WebsiteStats.new(data)
  end

  def run
    display_meta_data
    conversion_ranges
    analyze
  end

  def conversion_range(cohort)
    num_conversion = @stats.num_of_conversions(cohort)
    total = @stats.size_of_cohort(cohort)
    ABAnalyzer.confidence_interval(num_conversion, total, 0.95)
  end

  def analyze
    ab_test = ABAnalyzer::ABTest.new @stats.prep_data
    p_value = ab_test.chisquare_p.round(4)
    puts "Chi Squared p value is #{p_value}"
    test_hypothesis(p_value)
  end

  private

  def display_meta_data
    puts "Running an analysis on the following data:"
    @stats.prep_data.each { |k, v| puts "Cohort #{k}: #{v}" }
  end

  def conversion_ranges
    %w(A B).each do |cohort|
      range = conversion_range(cohort)
      puts "95% Conversion range for #{cohort} is #{range}"
    end
  end

  def test_hypothesis(p_value)
    if p_value >= 0.05
      puts "No correlated evidence from the data."
      false
    else
      puts "Data shows that the evidence is correlated!"
      true
    end
  end
end

ds = DataScience.new(DataFromFile.get("data_export_2014_06_20_15_59_02.json"))
ds.run
