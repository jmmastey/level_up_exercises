require_relative '../split_test_calculator.rb'

describe SplitTestCalculator do

  it "can be created using a hash of data" do
    @calc = SplitTestCalculator.new(control_views: 1349,
                                    control_conversions: 47,
                                    variation_views: 1543,
                                    variation_conversions: 79)
    expect(@calc.control_group.views).to eq(1349)
    expect(@calc.control_group.conversions).to eq(47)
    expect(@calc.variation_group.views).to eq(1543)
    expect(@calc.variation_group.conversions).to eq(79)
  end

  context "Created using hash" do
    let(:calc) do
      SplitTestCalculator.new(control_views: 1349,
                              control_conversions: 47,
                              variation_views: 1543,
                              variation_conversions: 79)
    end

    describe "#better_group" do
      it "can determine the group with the bigger conversion rate" do
        expect(calc.better_group).to eq(:variation_group)
      end
    end
  end
end
