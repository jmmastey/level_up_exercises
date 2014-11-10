require 'data_science/sample'

describe Sample do
  before do
    @sample = Sample.new
  end

  it 'is instantiated with an empty array of data points' do
    expect(@sample.data_points).to eq([])
  end
end
