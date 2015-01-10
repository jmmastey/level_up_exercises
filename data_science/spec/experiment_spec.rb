require "spec_helper"

describe Experiment do
  let(:experiment) { described_class.new("test_data.json") }

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
    conversion_rate = experiment.observed_conversion_rate("B")
    expect(conversion_rate).to eq(0.4)
  end

  it "calculates standard error" do
    expect(experiment.standard_error("B")).to eq(0.2191)
  end

  it "calculates expected conversion rate" do
    expect(experiment.expected_conversion_rate("B")).to eq(max: 40.44,
      min: 39.56)
  end
end
