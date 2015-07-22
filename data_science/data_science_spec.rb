require_relative('data_science.rb')
require('abanalyzer')

describe DataScience do
  before do
    @calculator = DataScience.new
    @calculator.load('json_test_files/small_test_data.json')
  end

  it 'should correctly load a small json dataset' do
    expect(@calculator.data_reader).to eq([
      { 'date' => '2014-03-20', 'cohort' => 'A', 'result' => 1 },
      { 'date' => '2014-03-20', 'cohort' => 'A', 'result' => 1 },
      { 'date' => '2014-03-20', 'cohort' => 'A', 'result' => 0 },
      { 'date' => '2014-03-20', 'cohort' => 'A', 'result' => 0 },
    ])
  end

  it 'should calculate the conversion rate of visitors' do
    expect(@calculator.conversion_rate('A')).to eq(0.50)
  end

  it 'should correctly calculate the total sample size' do
    expect(@calculator.total_size('A')).to eq(4)
  end

  it 'should correctly count the number of conversions' do
    expect(@calculator.number_of_conversions('A')).to eq(2)
  end

  it 'should calculate conversion rate with 95% confidence' do
    @calculator.load('json_test_files/statistics_test.json')
    conversion_rate = @calculator.conversion_rate('A')
    interval = @calculator.confidence_interval('A', 0.95)
    expect(conversion_rate).to be >= interval[0]
    expect(conversion_rate).to be <= interval[1]
  end

  it 'should give confidence level that current leader is better than random' do
    @calculator.load('json_test_files/statistics_test.json')
    # Accept H_0 if it is below 0.05 (should be for the engineered test data)
    expect(@calculator.chi_square_confidence).to be <= 0.05
  end
end
