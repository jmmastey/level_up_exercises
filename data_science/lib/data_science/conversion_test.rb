require 'json'
require_relative 'sample'
require 'active_support'
require 'active_support/core_ext/numeric/conversions'

module DataScience
  class ConversionTest
    attr_reader :name, :sample

    def initialize(name)
      @name = name
      @sample = Sample.new
    end

    def import_data(data)
      @sample.add_data_to_sample(data)
    end

    def print_statistical_results(group_1, group_2)
      puts "\nBelow are the results of the web conversion data:\n\n"
      puts "Total Size of the Control Group: #{@sample.cohort_size(group_1)}"
      puts "Number of Conversions for the Control Group: #{@sample.conversions(group_1)}\n\n"
      puts "Total Size of the Test Group: #{@sample.cohort_size(group_2)}"
      puts "Number of Conversions for the Test Group: #{@sample.conversions(group_2)}\n\n"
      puts "Conversion rate for the Control Group: #{@sample.conversion_rate(group_1).to_s(:rounded, precision: 2)} +- #{ @sample.error_bars(group_1).to_s(:percentage, precision: 2) }"
      puts "Conversion rate for the Test Group: #{@sample.conversion_rate(group_2).to_s(:rounded, precision: 2)} +- #{ @sample.error_bars(group_2).to_s(:percentage, precision: 2) }\n\n"
      puts "Confidence Level: #{@sample.confidence_level(group_1, group_2).to_s(:rounded, precision: 2)}\n\n"
    end
  end
end
