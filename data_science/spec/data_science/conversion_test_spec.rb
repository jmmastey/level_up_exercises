require 'data_science/conversion_test'

describe ConversionTest do
  before do
    @conversion_test = ConversionTest.new('sample_test')
  end

  it 'creates a new Conversion Test' do
    expect(@conversion_test).to be_an_instance_of(ConversionTest)
  end

  it 'has a name' do
    expect(@conversion_test.name).to eq("sample_test")
  end

  it 'creates a sample of data points' do
    expect(@conversion_test.sample).to be_an_instance_of(Sample)
  end

end
