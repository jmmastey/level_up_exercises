require 'json'
require_relative 'cohort'
require 'active_support'
require 'active_support/core_ext/numeric/conversions'
require 'abanalyzer'
require_relative 'view_helpers'


module DataScience
  class ConversionTest
    include ViewHelpers

    attr_reader :control_group, :test_group

    def initialize
      @control_group = Cohort.new
      @test_group = Cohort.new
    end

    def import_data(data)
      test_data, control_data = data.partition { |point| point["cohort"] == "A" }
      control_group.tally_conversions(control_data)
      test_group.tally_conversions(test_data)
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
      Conversion rate for the Control Group: #{@control_group.conversion_rate_helper} +- #{ @control_group.error_bars_helper }
      Conversion rate for the Test Group: #{@test_group.conversion_rate_helper} +- #{ @test_group.error_bars_helper }\n\n
      Confidence Level: #{confidence_level_helper}\n
    )
    end
  end
end
