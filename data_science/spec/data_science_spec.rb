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

  it 'should calculate the 95% confidence interval for A cohort' do
    a_result = @data_science.cohorts["A"].confidence_interval(0.95)
    expect(a_result[0]).to be_within(0.001).of(-0.042)
    expect(a_result[1]).to be_within(0.001).of(0.35)
  end

  it 'should calculate the 95% confidence interval for B cohort' do
    b_result = @data_science.cohorts["B"].confidence_interval(0.95)
    expect(b_result[0]).to be_within(0.001).of(-0.005)
    expect(b_result[1]).to be_within(0.001).of(0.358)
  end

  it 'should calculate if that the current leader is in fact better than random' do
    expect(@data_science.leader_is_better_than_random).to be false
  end
end
