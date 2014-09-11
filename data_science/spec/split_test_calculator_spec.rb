require_relative '../split_test_calculator.rb'

describe SplitTestCalculator do

  it "can be created using a hash of data" do
    control_group = SplitTestGroup.new(name: "A",
                                       views: 1349,
                                       conversions: 47)
    variation_group = SplitTestGroup.new(name: "B",
                                         views: 1543,
                                         conversions: 79)

    SplitTestCalculator.new(control_group: control_group,
                            variation_group: variation_group)
  end

  it "requires that the control and variation groups are assigned" do
    expect { SplitTestCalculator.new }.to raise_error(ArgumentError)
    expect { SplitTestCalculator.new(variation_group: SplitTestGroup.new) }
  end

  let(:calc) do
    control_group = SplitTestGroup.new(name: "A",
                                       views: 1349,
                                       conversions: 47)
    variation_group = SplitTestGroup.new(name: "B",
                                         views: 1543,
                                         conversions: 79)
    SplitTestCalculator.new(control_group: control_group,
                            variation_group: variation_group)
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
end
