require 'spec_helper'

describe ABCalculator do
  let(:test) { JsonParser.new("source_data.json") }
  #let(:parsed_data) { test.parsed_a_b_data }
  let(:calc) { ABCalculator.new(test) }
  let(:conversion_range) { calc.conversion_range }

  it "should create a new test object" do
    # p uts calc.to_s
  end

  it "should return sample size and number of conversions for each group" do
    expect(calc.sample_size[:a]).to be > 0
    expect(calc.sample_size[:b]).to be > 0
    puts calc.sample_size
    puts calc.no_of_conversions
    puts calc.conversion_rate
    puts calc.conversion_range
    puts calc.standard_error
    puts calc.confidence_level
  end

  it "should return valid %age of conversion data" do
    expect(calc.conversion_rate[:a]).to be_between(0, 1)
    expect(calc.conversion_rate[:b]).to be_between(0, 1)
  end

  it "should return error bars @ 95% confidence for conversion data" do
    expect(conversion_range[:a][:lo]).to be < conversion_range[:a][:hi]
    expect(conversion_range[:b][:lo]).to be < conversion_range[:b][:hi]
    expect(conversion_range[:a][:lo]).to be < calc.conversion_rate[:a]
    expect(conversion_range[:b][:lo]).to be < calc.conversion_rate[:b]
    expect(conversion_range[:a][:hi]).to be > calc.conversion_rate[:a]
    expect(conversion_range[:b][:hi]).to be > calc.conversion_rate[:b]
  end

  it "should return confidence level that current leader is better than random" do
    expect(calc.confidence_level).to be_between(0,1)
  end
end
