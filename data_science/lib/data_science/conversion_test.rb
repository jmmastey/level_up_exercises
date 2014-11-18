require 'json'
require_relative 'cohort'
require_relative 'json_parser'
require_relative 'view_helpers'
require 'active_support'
require 'active_support/core_ext/numeric/conversions'
require 'abanalyzer'

module DataScience
  class ConversionTest
    include ViewHelpers

    COHORT_MAPPING = {
      "test_group"    => "A",
      "control_group" => "B",
    }

    attr_reader :control_group, :test_group

    def initialize
      @control_group = Cohort.new
      @test_group = Cohort.new
    end

    def import_data(data)
      test_data, control_data = partition_data(data)
      control_group.tally_conversions(control_data)
      test_group.tally_conversions(test_data)
    end

    def partition_data(data)
      data.partition { |point| point["cohort"] == COHORT_MAPPING["test_group"] }
    end

    def confidence_level
      values = {}
      values[:group_1] =
        { non_conv: control_group.non_conversions, conv: control_group.conversions }
      values[:group_2] =
        { non_conv: test_group.non_conversions, conv: test_group.conversions }
      tester = ABAnalyzer::ABTest.new(values)
      1 - tester.chisquare_p
    end

    def print_statistical_results
      %(
      \nBelow are the results of the web conversion data:\n\n
      Total Size of the Control Group: #{@control_group.size}
      Number of Conversions for the Control Group: #{@control_group.conversions}\n\n
      Total Size of the Test Group: #{@test_group.size}
      Number of Conversions for the Test Group: #{@test_group.conversions}\n\n
      Conversion rate for the Control Group: #{conversion_rate_with_error}
      Conversion rate for the Test Group: #{conversion_rate_with_error}\n\n
      Confidence Level: #{confidence_level_helper}\n
    )
    end

    def conversion_rate_with_error
      "#{@control_group.conversion_rate_helper} +- #{@control_group.error_bars_helper}"
    end
  end
end
