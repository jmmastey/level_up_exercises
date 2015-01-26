require 'spec_helper'

describe Calculator do
  let(:calculator) { described_class.new("test_data.json") }

  it "calculates total conversions experiment" do
    total = calculator.chi_square
    expect(total).to eq(0.07)
  end
  it "calculates the winner to be A" do
    total = calculator.winner
    expect(total).to eq("A")
  end

  it "calculates the data is significant" do
    total = calculator.significant?
    expect(total).to eq(true)
  end

  it "calculates the expected conversions of the cohort" do
    conversions = calculator.expected_conversions("A")
    expect(conversions).to eq(3.75)
  end

  it "calculates the expected failures of the cohort" do
    failures = calculator.expected_failures("A")
    expect(failures).to eq(2.25)
  end

  it "calculates the p_value is significant" do
    pvalue = calculator.p_value
    expect(pvalue).to eq([25, 25])
  end
  it "calculates the degrees of freedom is significant" do
    dof = calculator.degrees_of_freedom
    expect(dof).to eq(1)
  end
end
