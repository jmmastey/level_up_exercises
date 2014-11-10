require 'data_science/sample'

describe Sample do
  before do
    @sample = Sample.new
    @sample_data = [{"date"=>"2014-03-20", "cohort"=>"B", "result"=>0}, {"date"=>"2014-03-20", "cohort"=>"B", "result"=>0}]
  end

  it 'is instantiated with an empty array of data points' do
    expect(@sample.data_points).to eq([])
  end

  it 'adds a data point to itself' do
    @sample.add_data_to_sample(@sample_data)
    expect(@sample.data_points.size).to eq(2)
  end

  context 'calculate sample statistics'
    before do

    end
    it 'calculates the total sample size' do

    end
end
