class Stat_Calculator
	def self.standard_error(probability, sample_size)
    raise ArgumentError, "Sample size must be greater than 0" if sample_size <= 0
    raise ArgumentError, "Probability must be between 0 and 1" if probability > 1.0 || probability < 0.0

		(((probability) * (1 - probability) / sample_size)**0.5).round(3)
	end

	def self.chi_square(*args)
    raise ArgumentError, "Expect numbers to calculate" if args.any? { |supposed_to_be_number| not_numeric?(supposed_to_be_number) }
    raise ArgumentError, "Numbers should be greater than 0" if args.any? { |element| element < 0 }
    raise NotImplementedError, "Not implemented chi_square calculation for non-2x2 experiment" unless args.size == 4

    a, b, c, d = args
		((((a.to_f * d - b * c) ** 2) * (a + b + c + d)) / 
		((a + b) * (c + d) * (b + d) * (a + c))).round(3)
	end

	def self.conversion(converted, hits)
    raise ArgumentError, "Require hits >= converted > 0" if converted < 0 || hits <= 0 || hits < converted

		(converted/hits.to_f).round(2)
	end

  private
  def self.not_numeric?(arg)
    return false if arg =~ /^\d+$/
    false if Float(arg) rescue true
  end
end
