require_relative "json_parser"
require_relative "data_box"

describe DataBox do
  let(:json) { JSONParser.new("source_data.json") }
  let(:dataset) { DataBox.new(json.fetch_data) }

  it "gives the correct percentage of conversions" do
    expect(dataset.conversion_percentage('A').round(4)).to eq(0.0348)
    expect(dataset.conversion_percentage('B').round(4)).to eq(0.0512)
  end

  it "gives correct calculation of standard error" do
    expect(dataset.standard_error('A')).to be_within(0.001).of(0.005)
    expect(dataset.standard_error('B')).to be_within(0.001).of(0.005)
  end

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
    expect(dataset.cohort_probabilities.round(4)).to eq(0.0316)
  end

  it "gives the correct winner" do
    expect(dataset.winner).to eq("Winner: Cohort B")
  end
end
