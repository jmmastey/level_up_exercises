require_relative "../chi_square"

describe ChiSquare do
  it "can be initialized with no parameters" do
    ChiSquare.new
  end

  let(:chi_square) { ChiSquare.new }
  let(:group_a) { SplitTestGroup.new(name: "A", views: 1349, conversions: 47) }
  let(:group_b) { SplitTestGroup.new(name: "B", views: 1543, conversions: 79) }

  describe "#test_statistic" do
    it "gets the chi-square test statistic from the provided groups" do
      result = chi_square.test_statistic(group_a, group_b)

      expect(result.round(2)).to eq(4.62)
    end
  end

  describe "#confidence_level" do
    it "gets the confidence level of differing probabilities from groups" do
      result = chi_square.confidence_level(group_a, group_b)

      expect(result.round(2)).to eq(0.97)
    end
  end
end
