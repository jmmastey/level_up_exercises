require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "DataScience" do
  # let(:sample) {  }
  
  # calculate the conversion rate of visitors as part of a split test.

  # Total sample size 
  it 'returns the sample size' do
    data_science = DataScience.new(
      File.read(File.expand_path("data/source_data.json"))    
    )
    
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
  
end
