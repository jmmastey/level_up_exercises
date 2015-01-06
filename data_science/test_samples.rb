require_relative 'data_conversion_loader'
require_relative 'sample'
require_relative 'sample_comparer'
require 'abanalyzer'

DATA_FIELDS = %w(date cohort result)
DATA_SIZE = 1349
DATA_CONVERSIONS_A = 47
DATA_NON_CONVERSIONS_A = 1302
CONFIDENCE = 0.95

def conversion_data
  DataConversionLoader.new("source_data.json").data
end

def conversion_data_a
  DataConversionLoader.new("source_data.json").sample_data("A")
end

def conversion_data_b
  DataConversionLoader.new("source_data.json").sample_data("B")
end

describe DataConversionLoader do
  let(:data) { conversion_data }
  let(:data_a) { conversion_data_a }

  it "should parse a JSON file" do
    expect(data).to be_an(Array)
  end

  it "should be able to parse the correct fields" do
    DATA_FIELDS.each { |field| expect(data[0]).to have_key(field) }
  end

  it "should have the same number of array elements as JSON elements" do
    elements = JSON.parse(File.read("source_data.json")).length
    expect(data.length).to eq(elements)
  end

  it "should understand how to filter by sample" do
    expect(data_a).to be_an(Array)
  end

  it "should keep the same fields after filter" do
    DATA_FIELDS.each { |field| expect(data_a[0]).to have_key(field) }
  end
end

describe Sample do
  let(:sample) { Sample.new(conversion_data_a) }

  describe "#new" do
    it "creates a sample with all conversion data for one sample passed to it" do
      expect(sample.size).to eq(conversion_data_a.length)
    end
  end

  it "should show correct conversions" do
    expect(sample.conversions).to eq(DATA_CONVERSIONS_A)
  end

  it "should show correct non-conversions" do
    expect(sample.non_conversions).to eq(DATA_NON_CONVERSIONS_A)
  end

  it "should have a size equal to conversions plus non-conversions" do
    expect(sample.size).to eq(sample.conversions + sample.non_conversions)
  end

  it "gives the correct confidence interval" do
    class_confidence = sample.confidence_interval(CONFIDENCE)
    check_confidence = ABAnalyzer.confidence_interval(DATA_CONVERSIONS_A, DATA_SIZE, CONFIDENCE)
    expect(class_confidence).to eq(check_confidence)
  end
end

describe SampleComparer do
  let(:sample_a) { Sample.new(conversion_data_a) }
  let(:sample_b) { Sample.new(conversion_data_b) }
  let(:comparer_same) { SampleComparer.new(sample_a, sample_a) }
  let(:comparer_different) { SampleComparer.new(sample_a, sample_b) }

  it "says an identical data set is not different" do
    expect(comparer_same.different?).to be(false)
  end

  it "says chisquare_p is smaller than #{CONFIDENCE}" do
    expect(comparer_different.chisquare_p).to be < CONFIDENCE
  end

  it "says a different data set is different" do
    expect(comparer_different.different?).to be(true)
  end
end
