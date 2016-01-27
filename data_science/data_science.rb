require './website_data'
require './website_stats'
require './data_from_file'
require 'abanalyzer'

class DataScience
  attr_accessor :loaded_stats

  def initialize(data_array)
    @loaded_stats = WebsiteStats.new(data_array)
  end

  def run
    display_meta_data
    conversion_ranges
    analyze
  end

  def display_meta_data
    puts "Running an analysis on the following data:"
    @loaded_stats.prep_data.each { |k, v| puts "Cohort #{k}: #{v}" }
  end

  def conversion_ranges
    %w(A B).each do |cohort_name|
      range = calc_conversion_ranges(cohort_name)
      puts "95% Conversion range for #{cohort_name} is #{range}"
    end
  end

  def calc_conversion_ranges(cohort_name)
    num_conversion = @loaded_stats.num_of_conversions(cohort_name)
    total = @loaded_stats.size_of_cohort(cohort_name)
    ABAnalyzer.confidence_interval(num_conversion, total, 0.95)
  end

  def analyze
    ab_test = ABAnalyzer::ABTest.new @loaded_stats.prep_data
    p_value = ab_test.chisquare_p.round(4)
    puts "Chi Squared p value is #{p_value}"
    test_hypo(p_value)
  end

  def test_hypo(p_value)
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
