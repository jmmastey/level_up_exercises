require_relative '../split_test_calculator.rb'

describe SplitTestCalculator do
  it "can be created without parameters" do
    calc = SplitTestCalculator.new
    expect(calc).to be_a(SplitTestCalculator)
  end

  it "can be created using a hash of data" do
    calc = SplitCalculator.new(control_visitors: 1349,
                               control_conversions: 47,
                               variation_visitors: 1543,
                               variation_conversions: 79)

    expect(calc.control_visitors).to eq(1349)
    expect(calc.control_conversions).to eq(47)
    expect(calc.variation_visitors).to eq(1543)
    expect(calc.variation_conversions).to eq(79)
  end

  context "Using source_data.json file" do

  end
end
