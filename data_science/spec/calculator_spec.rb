require 'spec_helper'

describe Calculator do
  let(:calculator) { described_class.new("test_data.json") }
  before do
    file     = File.open("test_data.json", "w")
    raw_data = [{ date: "2015-01-01", cohort: "A", result: 1 },
                { date: "2015-01-01", cohort: "A", result: 0 },
                { date: "2015-01-01", cohort: "B", result: 0 },
                { date: "2015-01-01", cohort: "B", result: 1 },
                { date: "2015-01-02", cohort: "B", result: 0 },
                { date: "2015-01-02", cohort: "A", result: 1 },
                { date: "2015-01-02", cohort: "B", result: 0 },
                { date: "2015-01-02", cohort: "B", result: 1 },
                { date: "2015-01-03", cohort: "A", result: 1 },
                { date: "2015-01-03", cohort: "A", result: 0 },
                { date: "2015-01-03", cohort: "B", result: 0 },
                { date: "2015-01-03", cohort: "B", result: 1 },
                { date: "2015-01-03", cohort: "B", result: 1 },
                { date: "2015-01-03", cohort: "A", result: 1 },
                { date: "2015-01-03", cohort: "B", result: 1 },
                { date: "2015-01-03", cohort: "B", result: 1 }]
    file.write(raw_data.map { |o| Hash[o.each_pair.to_a] }.to_json)
    file.rewind
  end

  it "calculates total conversions experiment" do
    total = described_class.new("test_data.json").chi_square
    expect(total).to eq(0.07)
  end
  it "calculates the winner to be A" do
    total = described_class.new("test_data.json").winner
    expect(total).to eq("A")
  end
end
