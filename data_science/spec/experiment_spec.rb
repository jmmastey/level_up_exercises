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

  it "calculates for all cohorts of experiment" do
    expect(experiment.visits_for_experiment["A"]).to eq(3)
  end

  it "calculates total conversions experiment" do
    total = described_class.new("test_data.json").total_conversions
    expect(total).to eq(4)
  end

  it "calculates total conversions experiment" do
    total = described_class.new("test_data.json").total_visits
    expect(total).to eq(8)
  end

  it "calculates average conversions experiment" do
    avg_conversions = described_class.new("test_data.json").average_conversions
    expect(avg_conversions).to eq(0.5)
  end

  it "calculates expected failures experiment" do
    expected_failures = described_class.new("test_data.json").expected_failures
    expect(expected_failures).to eq("A" => 1.5, "B" => 2.5)
  end

  it "calculates expected failures experiment" do
    expected_conversion = described_class.new("test_data.json").expected_conversions
    expect(expected_conversion).to eq("A" => 1.5, "B" => 2.5)
  end
end
