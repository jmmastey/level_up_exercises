require 'abanalyzer'

require 'data_science/ab_test/result'

module DataScience
  class ABTest
    def parse_test_results(a_cohort, b_cohort)
      a_conversion_rate = conversion_rate_95(a_cohort)
      b_conversion_rate = conversion_rate_95(b_cohort)

      confidence = chi_squared_confidence(a_cohort, b_cohort)

      Result.new(a_cohort, b_cohort, a_conversion_rate, b_conversion_rate, confidence)
    end

    private

    def conversion_rate_95(cohort)
      ABAnalyzer.confidence_interval(cohort.yes, cohort.size, 0.95)
    end

    def chi_squared_confidence(a_cohort, b_cohort)
      tester = ABAnalyzer::ABTest.new(a: a_cohort.to_h, b: b_cohort.to_h)
      1 - tester.chisquare_p
    end
  end
end
