require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'json'

describe DataScience do
  let (:data_science) do
    DataScience.new(load_json)
  end

  # calculate the conversion rate of visitors as part of a split test.

  # Total sample size
  it 'returns the sample size' do
    expect(data_science.sample_size).to eq(2892)
  end

  # Percentage of conversion (including error bars) with a 95% confidence.
  it 'returns the percentage of conversions (w/error bars) with 95% confidence'

  # Confidence level that the current leader is in fact better than random.
  # You should use the Chi-square test for this. Feel free to cheat with
  # a simple calculator to get your initial calculations.
  #
  # http://www.usereffect.com/split-test-calculator
  it 'calculates confidence interval that current leader is better than random'

  private

  def load_json
    raw_json = File.read(File.expand_path("data/source_data.json"))

    JSON.parse(raw_json)
  end
end
