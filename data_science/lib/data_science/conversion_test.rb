require 'json'
require_relative 'cohort'
require 'active_support'
require 'active_support/core_ext/numeric/conversions'

module DataScience
  class ConversionTest
    attr_reader :control_group, :test_group

    def initialize
      @control_group = Cohort.new("A")
      @test_group = Cohort.new("B")
    end

    def import_data(data)
      data.each do |point|
        @control_group << data if point["cohort"] == "A"
        @test_group << data if point["cohort"] == "B"
      end
    end

    def print_statistical_results(group_1, group_2)
      %(
      \nBelow are the results of the web conversion data:\n\n
      Total Size of the Control Group: #{@sample.cohort_size(group_1)}
      Number of Conversions for the Control Group: #{@sample.conversions(group_1)}\n\n
      Total Size of the Test Group: #{@sample.cohort_size(group_2)}
      Number of Conversions for the Test Group: #{@sample.conversions(group_2)}\n\n
      Conversion rate for the Control Group: #{@sample.conversion_rate_helper(group_1)} +- #{ @sample.error_bars_helper(group_1) }
      Conversion rate for the Test Group: #{@sample.conversion_rate_helper(group_2)} +- #{ @sample.error_bars_helper(group_2) }\n\n
      Confidence Level: #{@sample.confidence_level_helper(group_1, group_2)}\n
    )
    end
  end
end
