require "spec_helper"

describe Experiment do
  let(:data) { JsonParser.parse(File.open("test_data.json", "r")) }
  let(:experiment) { described_class.new(data) }

  it "calculates for all cohorts of experiment" do
    expect(experiment.visits_for_experiment["A"]).to eq(6)
  end

  it "calculates total conversions experiment" do
    total = experiment.total_conversions
    expect(total).to eq(10)
  end

  it "calculates total conversions experiment" do
    total = experiment.total_visits
    expect(total).to eq(16)
  end

  it "calculates average conversions experiment" do
    avg_conversions = experiment.average_conversions
    expect(avg_conversions).to eq(0.625)
  end

  it "calculates expected failures experiment" do
    expected_failures = experiment.expected_failures
    expect(expected_failures).to eq("A" => 2.25, "B" => 3.75)
  end

  it "calculates expected failures experiment" do
    expected_conversion = experiment.expected_conversions
    expect(expected_conversion).to eq("A" => 3.75, "B" => 6.25)
  end
end
