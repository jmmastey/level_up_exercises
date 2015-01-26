require 'spec_helper'

describe Cohort do
  let(:data) { { "A" => { "total_visits" => 3, "conversions" => 2 } } }

  let(:cohort) { described_class.new(data) }

  it "calculates conversions for experiment" do
    conversion_rate = cohort.conversion_rate
    expect(conversion_rate).to eq(0.6667)
  end

  it "calculates standard_error for experiment" do
    expect(cohort.standard_error).to eq(0.2722)
  end

  it 'calculates expected conversion rate' do
    expect(cohort.expected_conversion_rate).to eq(max: 67.21,
      min: 66.13)
  end
end
