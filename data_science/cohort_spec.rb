require_relative "cohort"
require_relative "json_parser"

describe Cohort do
  let(:json) { JSONParser.new("cohort_a_data.json") }
  let(:cohort) { Cohort.new(json.fetch_data, 'A') }

  it "gives the correct percentage of conversions" do
    expect(cohort.conversion_percentage.round(4)).to eq(0.6)
  end

  it "gives the correct size of cohort" do
    expect(cohort.size).to eq(10)
  end

  it "gives correct calculation of standard error" do
    expect(cohort.standard_error).to be_within(0.1).of(0.2)
  end
end
