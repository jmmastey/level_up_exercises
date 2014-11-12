 require_relative 'data_point'
require 'abanalyzer'

module DataScience
  class Sample
    attr_accessor :data_points

    CONVERSION_RATE_MULTIPLIER_FOR_95_CONFIDENCE = 1.96

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
      @data_points.select { |visitor| visitor.cohort == cohort && visitor.result == 1 }.size
    end

    def non_conversions(cohort)
      @data_points.select { |visitor| visitor.cohort == cohort && visitor.result == 0 }.size
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
      standard_error(cohort) * CONVERSION_RATE_MULTIPLIER_FOR_95_CONFIDENCE * 100
    end

    def confidence_level(group_1, group_2)
      values = {}
      values[:group_1] = { non_conversions: non_conversions(group_1), conversions: conversions(group_1) }
      values[:group_2] = { non_conversions: non_conversions(group_2), conversions: conversions(group_2) }
      tester = ABAnalyzer::ABTest.new(values)
      1 - tester.chisquare_p
    end

    def print_error_bars(cohort)
      error_bars(cohort).to_s(:percentage, precision: 2)
    end

    def print_conversion_rate(cohort)
      conversion_rate(cohort).to_s(:rounded, precision: 2)
    end

    def print_confidence_level(group_1, group_2)
      (confidence_level(group_1, group_2) * 100).to_s(:percentage, precision: 1)
    end
  end
end
