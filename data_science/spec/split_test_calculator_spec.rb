require_relative '../split_test_calculator.rb'

describe SplitTestCalculator do
  let(:control_group) do
    SplitTestGroup.new(name: "A",
                       num_views: 1349,
                       num_conversions: 47)
  end

  let(:variation_group) do
    SplitTestGroup.new(name: "B",
                       num_views: 1543,
                       num_conversions: 79)
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

  describe "#to_s" do
    subject(:formatted_calculator) { calc.to_s }

    it "should include the control group's #to_s output" do
      expect(formatted_calculator).to include(control_group.to_s)
    end

    it "should include the variation group's #to_s output" do
      expect(formatted_calculator).to include(variation_group.to_s)
    end

    it "should include the confidence in superiority" do
      expect(formatted_calculator).to include("Confidence in superiority: 96")
    end

    it "should identify the superior group" do
      expect(formatted_calculator).to include("Group 'B' is superior.")
    end
  end
end
