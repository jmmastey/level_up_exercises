require 'rspec'
require_relative 'data_science'

describe 'execution' do
  subject(:data_science) do
    DataScience.new("test_data.json")
  end

  it 'should load a test file into cohorts' do
    expect(data_science.cohorts.length).to be == 2
  end

  it 'should calculate the sample size for each cohort' do
    expect(data_science.cohorts["A"].sample_size).to be == 13
    expect(data_science.cohorts["B"].sample_size).to be == 17
  end

  it 'should calculate the conversion rate for each cohort' do
    expect(data_science.cohorts["A"].conversion_rate).to be == 2.to_f / 13
    expect(data_science.cohorts["B"].conversion_rate).to be == 3.to_f / 17
  end

  it 'should calculate the conversion count for each cohort' do
    expect(data_science.cohorts["A"].conversion_count).to be == 2
    expect(data_science.cohorts["B"].conversion_count).to be == 3
  end

  it 'should calculate the 95% confidence interval for A cohort' do
    a_result = data_science.cohorts["A"].confidence_interval(0.95)
    expect(a_result[0]).to be_within(0.001).of(-0.042)
    expect(a_result[1]).to be_within(0.001).of(0.35)
  end

  it 'should calculate the 95% confidence interval for B cohort' do
    b_result = data_science.cohorts["B"].confidence_interval(0.95)
    expect(b_result[0]).to be_within(0.001).of(-0.005)
    expect(b_result[1]).to be_within(0.001).of(0.358)
  end

  it 'should determine the leading cohort' do
    expect(data_science.leader_name).to be == "B"
  end
end

describe 'display' do
  subject(:data_science) do
    @data_science = DataScience.new("test_data.json")
  end

  it 'should show the results on the console' do
    output = <<-U_C_ME
Cohort  Samples  Conversions  Rate      Confidence Interval
A       13       2            15.4%     -4.2% to 35.0%
B       17       3            17.6%     -0.5% to 35.8%

p value = 100.000
The leader (B) is not better than random.
U_C_ME

    expect { DataScience.new("test_data.json") }.to output(output).to_stdout
  end
end