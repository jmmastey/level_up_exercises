require_relative('data_science.rb')

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe DataScience do
  before do
    @calculator = DataScience.new
    @calculator.load('json_test_files/small_test_data.json')
  end

  it 'should correctly load a small json dataset' do
    @calculator.data.should == [
        {'date' => '2014-03-20', 'cohort' => 'A', 'result' => 1},
        {'date' => '2014-03-20', 'cohort' => 'A', 'result' => 1},
        {'date' => '2014-03-20', 'cohort' => 'A', 'result' => 0},
        {'date' => '2014-03-20', 'cohort' => 'A', 'result' => 0},
    ]
  end

  it 'should calculate the conversion rate of visitors' do
    @calculator.conversion_rate.should == 0.50
  end

  it 'should correctly calculate the total sample size' do
    @calculator.total_size.should == 4
  end

  it 'should correctly count the number of visitors' do
    @calculator.number_of_conversions.should == 2
  end


end