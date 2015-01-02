require_relative 'load_conversion_data'
require_relative 'sample'
require_relative 'compare_samples'

def conversion_data
  LoadConversionData.new("source_data.json")
end

def conversion_data_a
  conversion_data.sample_data("A")
end

def conversion_data_b
  conversion_data.sample_data("B")
end

describe LoadConversionData do
  it "should parse a JSON file" do
    expect(conversion_data.data).to be_an(Array)
  end

  it "should understand how to filter by sample" do
    expect(conversion_data_a).to be_an(Array)
  end
end

describe Sample do
  it "should have a size equal to the array length" do
    sample = Sample.new(conversion_data.data)
    expect(sample.size).to eq(conversion_data.data.length)
  end

  it "should show conversions" do
    sample = Sample.new(conversion_data_a)
    expect(sample.conversions).to be_an(Integer)
    puts "Conversions: #{sample.conversions}"
  end

  it "should have a size equal to conversions plus non-conversions" do
    sample = Sample.new(conversion_data_a)
    expect(sample.size).to eq(sample.conversions + sample.non_conversions)
  end

  it "can give a confidence interval" do
    sample = Sample.new(conversion_data_a)
    confidence = sample.confidence_interval(0.95)
    expect(confidence).to be_an(Array)
  end
end

describe CompareSamples do
  it "says an identical data set is not different" do
    sample = Sample.new(conversion_data_a)
    different = CompareSamples.new(sample, sample).different?
    expect(different).to be(false)
  end

  it "says a different data set is different" do
    sample_a = Sample.new(conversion_data_a)
    sample_b = Sample.new(conversion_data_b)
    compare = CompareSamples.new(sample_a, sample_b)
    if compare.chisquare_p < 0.95
      expect(compare.different?).to be(true)
    else
      raise "Test data sets are not different"
    end
  end
end
