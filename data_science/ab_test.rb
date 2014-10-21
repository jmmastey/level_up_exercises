class ABTestCalculator
  class ABTest
    attr_reader :groupA, :groupB, :chi_square, :significant_95_percentile

    def initialize
      @group_A = ABTestGroup.new
      @group_B = ABTestGroup.new
    end
  end
end
