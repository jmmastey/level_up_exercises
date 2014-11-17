module DataScience
  module ViewHelpers
    def error_bars_helper(cohort)
      error_bars(cohort).to_s(:percentage, precision: 2)
    end

    def conversion_rate_helper(cohort)
      (conversion_rate(cohort) * 100).to_s(:percentage, precision: 1)
    end

    def confidence_level_helper(group_1, group_2)
      (confidence_level(group_1, group_2) * 100).to_s(:percentage, precision: 1)
    end
  end
end
