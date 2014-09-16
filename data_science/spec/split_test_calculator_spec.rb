require_relative '../split_test_calculator.rb'

describe SplitTestCalculator do

  it "can be created using a hash of data" do
    control_group = SplitTestGroup.new(name: "A",
                                       views: 1349,
                                       conversions: 47)
    variation_group = SplitTestGroup.new(name: "B",
                                         views: 1543,
                                         conversions: 79)

    SplitTestCalculator.new(control_group, variation_group)
  end

  it "requires that the control and variation groups are assigned" do
    expect { SplitTestCalculator.new(nil, nil)}.to raise_error(ArgumentError)
    expect { SplitTestCalculator.new(nil, SplitTestGroup.new).to raise_error(ArgumentError) }
  end

  let(:calc) do
    control_group = SplitTestGroup.new(name: "A",
                                       views: 1349,
                                       conversions: 47)
    variation_group = SplitTestGroup.new(name: "B",
                                         views: 1543,
                                         conversions: 79)
    SplitTestCalculator.new(control_group, variation_group)
  end

  describe "#better_group" do
    it "can determine the group with the bigger conversion rate" do
      expect(calc.better_group).to eq(:variation_group)
    end
  end

  describe "#confident?" do
    it "returns true if 95% confident in a difference between the variations" do
      expect(calc).to be_confident
    end
  end

  describe "#confidence_level" do
    it "returns the confidence level of a difference in probabilities" do
      expect(calc.confidence_level.round(2)).to eq(0.97)
    end
  end
end
