require 'abanalyzer'

class ABCalculator
  def initialize(a_conv, a_nonconv, b_conv, b_nonconv)
    validate_inputs([a_conv, a_nonconv], [b_conv, b_nonconv])
    a_b_tally = {
      a: { conv: a_conv, nonconv: a_nonconv },
      b: { conv: b_conv, nonconv: b_nonconv },
    }
    @a_b_test = ABAnalyzer::ABTest.new(a_b_tally)
  end

  def confidence_level
    (1 - @a_b_test.chisquare_p).round(6)
  end

  private

  def validate_inputs(a_tally, b_tally)
    raise TypeError unless (a_tally + b_tally).all? { |i| i.is_a? Fixnum }
    raise ArgumentError unless (a_tally + b_tally).all? { |i| i >= 0 }
    raise ArgumentError unless a_tally.inject(:+) > 0
    raise ArgumentError unless b_tally.inject(:+) > 0
  end
end
