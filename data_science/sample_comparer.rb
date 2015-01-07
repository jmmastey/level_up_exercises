require 'abanalyzer'

class SampleComparer
  def initialize(sample_a, sample_b)
    @tester = ABAnalyzer::ABTest.new(samples(sample_a, sample_b))
  end

  def different?
    tester.different?
  end

  def chisquare_p
    tester.chisquare_p
  end

  private

  attr_reader :tester

  def samples(sample_a, sample_b)
    { agroup: { conversions: sample_a.conversions,
                non_conversions: sample_a.non_conversions },
      bgroup: { conversions: sample_b.conversions,
                non_conversions: sample_b.non_conversions } }
  end
end
