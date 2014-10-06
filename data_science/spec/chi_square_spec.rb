require_relative "../chi_square"

describe ChiSquare do
  let(:chi_square) { ChiSquare.new }
  let(:group_a_num_conversions) { 47 }
  let(:group_b_num_conversions) { 79 }
  let(:group_a_num_views) { 1349 }
  let(:group_b_num_views) { 1543 }

  let(:group_a) do
    SplitTestGroup.new(name: "A",
                       num_views: group_a_num_views,
                       num_conversions: group_a_num_conversions)
  end

  let(:group_b) do
    SplitTestGroup.new(name: "B",
                       num_views: group_b_num_views,
                       num_conversions: group_b_num_conversions)
  end

  it "can be initialized with no parameters" do
    ChiSquare.new
  end

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
