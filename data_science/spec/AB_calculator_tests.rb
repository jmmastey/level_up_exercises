require 'spec_helper'

describe ABCalculator do

  let(:test) { JsonParser.new("source_data.json") }
  let(:parsed_data) { test.parsed_ab_data }
  let(:calc) { ABCalculator.new(parsed_data) }

	it "should create a new test object" do
    puts calc.to_s
  end

  it "shoud return sample size and number of conversions for each group" do
    puts calc.sample_size
    expect(calc.sample_size[:a_total]).to be > 0
    expect(calc.sample_size[:b_total]).to be > 0
    expect(calc.conversion_rate[:a_conversion]).to be > 0
    expect(calc.conversion_rate[:b_conversion]).to be > 0

  end

  it "should return %age of conversion (with error bars) @ 95% confidence"

  it "should return confidence level that current leader is better than random"

end