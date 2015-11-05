module DataScience
  class ABTest
    class Result
      def pretty_print(pp)
        pp.text("A Conversions: #{@a_cohort.yes}/#{@a_cohort.size}")
        pp.breakable

        pp.text("A Conversion Rate (95%): #{conversion_rate_to_s(@a_conversion_rate)}")
        pp.breakable

        pp.text("B Conversions: #{@b_cohort.yes}/#{@b_cohort.size}")
        pp.breakable

        pp.text("B Conversion Rate (95%): #{conversion_rate_to_s(@b_conversion_rate)}")
        pp.breakable

        pp.text("Confidence: #{float_to_s(@confidence)}")
      end

      private

      def conversion_rate_to_s(conversion_rate)
        "#{float_to_s(conversion_rate[0])} - #{float_to_s(conversion_rate[1])}"
      end

      def float_to_s(rate)
        "#{(rate * 100).round(2)}%"
      end
    end
  end
end
