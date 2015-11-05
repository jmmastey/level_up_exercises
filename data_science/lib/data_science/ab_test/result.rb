require 'data_science/ab_test/result_pp'

module DataScience
  class ABTest
    class Result
      attr_reader :a_cohort, :b_cohort, :a_conversion_rate, :b_conversion_rate, :confidence

      def initialize(a_cohort, b_cohort, a_conversion_rate, b_conversion_rate, confidence)
        @a_cohort = a_cohort
        @b_cohort = b_cohort
        @a_conversion_rate = a_conversion_rate
        @b_conversion_rate = b_conversion_rate
        @confidence = confidence
      end
    end
  end
end
