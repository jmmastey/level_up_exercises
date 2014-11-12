module DataScience
  module ViewHelpers
    def print_error_bars(cohort)
      error_bars(cohort).to_s(:percentage, precision: 2)
    end

    def print_conversion_rate(cohort)
      (conversion_rate(cohort) * 100).to_s(:percentage, precision: 1)
    end

    def print_confidence_level(group_1, group_2)
      (confidence_level(group_1, group_2) * 100).to_s(:percentage, precision: 1)
    end
  end
end
