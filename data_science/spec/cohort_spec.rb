require 'spec_helper'

describe Cohort do
  let(:data) { { "A" => { "total_visits" => 3, "conversions" => 2 } } }

  let(:cohort) { described_class.new(data) }

  before do
    file     = File.open("test_data.json", "w")
    raw_data = [{ date: "2015-01-01", cohort: "A", result: 1 },
                { date: "2015-01-01", cohort: "A", result: 0 },
                { date: "2015-01-01", cohort: "B", result: 0 },
                { date: "2015-01-01", cohort: "B", result: 1 },
                { date: "2015-01-02", cohort: "B", result: 0 },
                { date: "2015-01-02", cohort: "A", result: 1 },
                { date: "2015-01-02", cohort: "B", result: 0 },
                { date: "2015-01-02", cohort: "B", result: 1 }]
    file.write(raw_data.map { |o| Hash[o.each_pair.to_a] }.to_json)
    file.rewind
  end

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