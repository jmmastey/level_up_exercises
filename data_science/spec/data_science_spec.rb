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
  
  it 'calculates the conversions for each cohort' do
    data_science = DataScience.new(
      File.read(File.expand_path("data/source_data.json"))    
    )
    
    expect(data_science.cohorts['A'].conversions).to eq(47)
    expect(data_science.cohorts['B'].conversions).to eq(79)
  end

  it 'calculates the trials for each cohort' do
    data_science = DataScience.new(
      File.read(File.expand_path("data/source_data.json"))    
    )
    
    expect(data_science.cohorts['A'].trials).to eq(1349)
    expect(data_science.cohorts['B'].trials).to eq(1543)
  end
  
  it 'calculates the conversion rate for each cohort' do
    data_science = DataScience.new(
      File.read(File.expand_path("data/source_data.json"))
    )

    expect(data_science.cohorts['A'].conversion_rate).to eq(0.035)
    expect(data_science.cohorts['B'].conversion_rate).to eq(0.051)
  end
  
  it 'calculates the standard error for each cohort' do
    data_science = DataScience.new(
      File.read(File.expand_path("data/source_data.json"))
    )

    expect(data_science.cohorts['A'].standard_error).to eq(0.005)
    expect(data_science.cohorts['B'].standard_error).to eq(0.006)
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
