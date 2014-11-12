require 'data_science/conversion_test'
require 'data_science/json_parser'

module DataScience
  describe ConversionTest do
    let(:conversion_test) { ConversionTest.new('sample_test') }

    it 'has a name' do
      expect(conversion_test.name).to eq("sample_test")
    end

    it 'creates a sample of data points' do
      expect(conversion_test.sample).to be_an_instance_of(Sample)
    end

    describe '#import_data' do
      it 'creates a sample of data points from a json file' do
        json_file = File.join(File.dirname(__FILE__), "source_data_test.json")
        json_data = JsonParser.parse_file(json_file)
        conversion_test.import_data(json_data)
        expect(conversion_test.sample.data_points.size).to eq(4)
      end
    end
  end
end
