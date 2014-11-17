module DataScience
  module ViewHelpers
    def error_bars_helper
      error_bars.to_s(:percentage, precision: 2)
    end

    def conversion_rate_helper
      (conversion_rate * 100).to_s(:percentage, precision: 1)
    end

    def confidence_level_helper
      (confidence_level * 100).to_s(:percentage, precision: 1)
    end
  end
end
