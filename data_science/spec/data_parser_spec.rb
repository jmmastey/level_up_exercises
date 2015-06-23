require_relative '../data_parser'
require_relative '../error/format_error'
require_relative '../error/value_error'

test_data = [
  { cohort: 'A', result: 0 },
  { cohort: 'A', result: 1 },
  { cohort: 'B', result: 0 },
  { cohort: 'B', result: 1 },
  { cohort: 'B', result: 1 },
  { cohort: 'C', result: 0 },
]

describe 'DataParser' do
  let(:parser) { DataParser.new(test_data) }

  it "should accept and store a dataset on instantiation" do
    expect(parser.data).to eq(test_data)
  end

  context "data is missing required key" do
    it "should raise error if key :cohort is missing" do
      invalid_cohort = [{ group: 'A', result: 1 }]
      expect { DataParser.new(invalid_cohort) }.to raise_error(FormatError)
    end

    it "should raise error if key :result is missing" do
      invalid_result = [{ cohort: 'A', visits: 1 }]
      expect { DataParser.new(invalid_result) }.to raise_error(FormatError)
    end
  end

  context "invalid values" do
    it "should raise error if :result values out of range" do
      invalid_value = [{ cohort: 'A', result: 3 }]
      expect { DataParser.new(invalid_value) }.to raise_exception(ValueError)
    end
  end

  describe "#sample_size" do
    it "should return the correct sample size for a given cohort" do
      expect(parser.sample_size("A")).to eq(2)
      expect(parser.sample_size("B")).to eq(3)
      expect(parser.sample_size("C")).to eq(1)
    end

    it "should return 0 for a cohort that does not exist in the dataset" do
      expect(parser.sample_size("X")).to eq(0)
    end
  end

  describe "#num_conversions" do
    it "should return the correct number of conversions for a given cohort" do
      expect(parser.num_conversions("A")).to eq(1)
      expect(parser.num_conversions("B")).to eq(2)
      expect(parser.num_conversions("C")).to eq(0)
    end

    it "should return 0 for a cohort that does not exist in the dataset" do
      expect(parser.num_conversions("X")).to eq(0)
    end
  end

  describe '#summary' do
    it "should be a hash of each cohort's conversions and non-conversions" do
      expect(parser.summary['A'][:conversions]).to eq(1)
      expect(parser.summary['A'][:non_conversions]).to eq(1)
      expect(parser.summary['B'][:conversions]).to eq(2)
      expect(parser.summary['B'][:non_conversions]).to eq(1)
      expect(parser.summary['C'][:conversions]).to eq(0)
      expect(parser.summary['C'][:non_conversions]).to eq(1)
    end
  end
end
