require_relative 'data_point'
require_relative 'view_helpers'
require 'abanalyzer'

module DataScience
  class Sample
    include ViewHelpers

    attr_accessor :data_points

    CONVERSION_RATE_MULTIPLIER_95_CONFIDENCE = 1.96

    def initialize
      @data_points = []
    end

    def add_data_to_sample(data_source)
      data_source.each do |data|
        @data_points << create_data_point(data)
      end
    end

    def create_data_point(data)
      DataPoint.new(data)
    end

    def sample_size
      @data_points.size
    end

    def conversions(cohort)
      number_of_conversions = @data_points.select do |visitor|
        visitor.cohort == cohort && visitor.result == 1
      end
      number_of_conversions.size
    end

    def non_conversions(cohort)
      number_of_non_conversions = @data_points.select do |visitor|
        visitor.cohort == cohort && visitor.result == 0
      end
      number_of_non_conversions.size
    end

    def cohort_size(cohort)
      @data_points.select { |visitor| visitor.cohort == cohort }.size
    end

    def conversion_rate(cohort)
      1.0 * conversions(cohort) / cohort_size(cohort)
    end

    def standard_error(cohort)
      Math.sqrt(conversion_rate(cohort) * (1 - conversion_rate(cohort)) / cohort_size(cohort))
    end

    def error_bars(cohort)
      standard_error(cohort) * CONVERSION_RATE_MULTIPLIER_95_CONFIDENCE * 100
    end

    def confidence_level(group_1, group_2)
      values = {}
      values[:group_1] =
        { non_conversions: non_conversions(group_1), conversions: conversions(group_1) }
      values[:group_2] =
        { non_conversions: non_conversions(group_2), conversions: conversions(group_2) }
      tester = ABAnalyzer::ABTest.new(values)
      1 - tester.chisquare_p
    end
  end
end
