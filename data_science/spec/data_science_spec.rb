require 'rspec'
require 'data_science'

describe 'execution' do
  before(:each) do
    @data_science = DataScience.new("test_data.json")
  end

  it 'should run' do
  end

  it 'should load a test file into cohorts' do
    expect(@data_science.cohorts.length).to be == 2
  end

  it 'should calculate the sample size for each cohort' do
    expect(@data_science.cohorts["A"].sample_size).to be == 13
    expect(@data_science.cohorts["B"].sample_size).to be == 17
  end

  it 'should calculate the conversion rate for each cohort' do
    expect(@data_science.cohorts["A"].conversion_rate).to be == 2.to_f / 13
    expect(@data_science.cohorts["B"].conversion_rate).to be == 3.to_f / 17
  end

  it 'should calculate the conversion count for each cohort' do
    expect(@data_science.cohorts["A"].conversion_count).to be == 2
    expect(@data_science.cohorts["B"].conversion_count).to be == 3
  end
end
