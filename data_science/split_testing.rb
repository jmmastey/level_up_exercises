require 'active_support/all'
require './model/sample.rb'

class SplitTesting

  attr_accessor :sample

  def initialize
    @sample = Model::Sample.new
    run
  end

  def run
    puts "Test Results: Total Sample Size = #{@sample.total_size}"
    @sample.get_cohorts.sort.each do |cohort|
      puts "The number of conversions for cohort: #{cohort} is #{@sample.cohort_conversions(cohort)}."
      puts "The number of non conversions for cohort: #{cohort} is #{@sample.cohort_non_conversions(cohort)}."
      puts "The conversion rate for cohort: #{cohort} is #{format_output(@sample.conversion_rate(cohort))}"
      puts "With an error bar of #{format_output(@sample.error_bars(cohort), :error_bar => true)}."
    end
    puts "The confidence level for this test is #{format_output(@sample.calculate_confidence_level)}."
  end

  def format_output(value, options = {})
    unless options[:error_bar]
      return (value * 100).to_s(:percentage, :precision => 1)
    end
    value.to_s(:percentage, :precision => 2)
  end
end

SplitTesting.new
