require_relative "json_parser"
require_relative "data_box"

describe DataBox do
  let(:json) { JSONParser.new("source_data.json") }
  let(:dataset) { DataBox.new(json.fetch_data) }

  context "when calculating the chi-square probability" do
    subject(:probabilities) { DataBox.new({}) }
    it "raises Insufficient Data Error" do
      raise_error(ABAnalyzer::InsufficientDataError)
    end
  end

  it "gives the correct sample size" do
    expect(dataset.sample_size).to eq(2892)
  end

  it "gives the correct chi-square p-value" do
    expect(dataset.winner_significance.round(4)).to eq(0.0316)
  end

  it "gives the correct winner" do
    expect(dataset.winner).to eq("Winner: Cohort B")
  end
end
