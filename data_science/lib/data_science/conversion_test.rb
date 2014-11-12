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
      %(
      \nBelow are the results of the web conversion data:\n\n
      Total Size of the Control Group: #{@sample.cohort_size(group_1)}
      Number of Conversions for the Control Group: #{@sample.conversions(group_1)}\n\n
      Total Size of the Test Group: #{@sample.cohort_size(group_2)}
      Number of Conversions for the Test Group: #{@sample.conversions(group_2)}\n\n
      Conversion rate for the Control Group: #{@sample.print_conversion_rate(group_1)} +- #{ @sample.print_error_bars(group_1) }
      Conversion rate for the Test Group: #{@sample.print_conversion_rate(group_2)} +- #{ @sample.print_error_bars(group_2) }\n\n
      Confidence Level: #{@sample.print_confidence_level(group_1, group_2)}\n
    )
    end
  end
end
