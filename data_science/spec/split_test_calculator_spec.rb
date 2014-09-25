require_relative '../split_test_calculator.rb'

describe SplitTestCalculator do
  let(:control_group) do
    SplitTestGroup.new(name: "A",
                       views: 1349,
                       conversions: 47)
  end

  let(:variation_group) do
    SplitTestGroup.new(name: "B",
                       views: 1543,
                       conversions: 79)
  end

  let(:calc) { SplitTestCalculator.new(control_group, variation_group) }

  it "can be created using an array of groups" do
    expect { calc }.not_to raise_error
  end

  describe "#better_group" do
    it "can determine the group with the bigger conversion rate" do
      expect(calc.better_group).to eq(variation_group)
    end
  end

  describe "#confidence_level" do
    it "returns the confidence level of a difference in probabilities" do
      expect(calc.confidence_level.round(2)).to eq(0.97)
    end
  end
end
