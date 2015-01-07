require "spec_helper"

describe Experiment do

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

  it "calculates conversion rates" do
    conversion_rate = described_class.new("test_data.json").observed_conversion_rate("B")
    expect(conversion_rate).to eq(40)
  end

  it "calculates total sample size" do
    expect(described_class.new("test_data.json").total_visits).to eq(8)
  end

  it "calculates standard error" do
    expect(described_class.new("test_data.json").standard_error("B")).to eq(21.91)
  end
end