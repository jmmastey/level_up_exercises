require 'spec_helper'

describe Calculator do
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

  it "calculates conversions for each experiment" do
    conversions = described_class.new("test_data.json").conversion_rate_for_experiments
    expect(conversions["B"]).to eq(0.4)
    expect(conversions["A"]).to eq(0.6667)
  end

  it "calculates standard error for each experiment" do
    error = described_class.new("test_data.json").standard_error_for_experiments
    expect(error["B"]).to eq(0.2191)
    expect(error["A"]).to eq(0.2722)
  end

  it "calculates total conversions experiment" do
    total = described_class.new("test_data.json").total_conversions
    expect(total).to eq(4)
  end

  it "calculates total conversions experiment" do
    total = described_class.new("test_data.json").total_visits
    expect(total).to eq(8)
  end
  it "calculates total conversions experiment" do
    total = described_class.new("test_data.json").chi_square
    expect(total).to eq(0.53)
  end
end