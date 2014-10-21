require_relative "../ab_test_calculator.rb"

describe ABTestCalculator do

  it "accepts and sums visitors to group A" do
    ab_test_calculator = ABTestCalculator.new
    ab_test_calculator.add_visitors_A(3, 1)
    ab_test_calculator.add_visitors_A(5, 2)
    expect(ab_test_calculator.visitors_A).to eq(8)
    expect(ab_test_calculator.converts_A).to eq(3)
  end  

  it "accepts visitors to group B" do
    ab_test_calculator = ABTestCalculator.new
    ab_test_calculator.add_visitors_B(3, 1)
    ab_test_calculator.add_visitors_B(5, 2)
    expect(ab_test_calculator.visitors_B).to eq(8)
    expect(ab_test_calculator.converts_B).to eq(3)
  end

  let(:result) do
    ab_test_calculator = ABTestCalculator.new
    ab_test_calculator.add_visitors_A(23453, 1035)
    ab_test_calculator.add_visitors_B(3564, 153)
    result = ab_test_calculator.compute
  end

  it "copies data set into result" do
    expect(result.to_h).to include(
      :visitors_A => 23453,
      :converts_A    => 1035,
      :visitors_B => 3564,
      :converts_B    => 153
    )
  end

  it "computes valid conversion ratios for group A" do
    expect(result.conversion_ratio_A).to be_within(0.0001).of(0.0441)
  end

  it "computes valid conversion rate standard errror for group A" do
    expect(result.standard_error_A).to be_within(0.0001).of(0.00134)
  end

  it "computes valid conversion rate 95% error margin for group A" do
    expect(result.error_margin_A).to be_within(0.0001).of(0.00263)
  end

  it "computes valid conversion ratios for group B" do
    expect(result.conversion_ratio_B).to be_within(0.0001).of(0.0429)
  end

  it "computes valid conversion rate standard errror for group B" do
    expect(result.standard_error_B).to be_within(0.0001).of(0.00340)
  end

  it "computes valid conversion rate 95% error margin for group B" do
    expect(result.error_margin_B).to be_within(0.0001).of(0.00665)
  end

  it "properly fails to reject null hypothesis" do
    expect(result.significant_95_percentile).to be(false)
  end

  it "properly rejects null hypothesis" do
    ab_test_calculator = ABTestCalculator.new
    ab_test_calculator.add_visitors_A(1349, 47)
    ab_test_calculator.add_visitors_B(1543, 79)
    result = ab_test_calculator.compute
    expect(result.significant_95_percentile).to be(true)
  end
end
