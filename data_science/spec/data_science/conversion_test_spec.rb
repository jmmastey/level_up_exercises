require 'data_science/conversion_test'
require 'data_science/json_parser'

module DataScience
  describe ConversionTest do
    let(:conversion_test) { ConversionTest.new('sample_test') }

    it 'has a name' do
      expect(conversion_test.name).to eq("sample_test")
    end

    describe '#import_data' do
      it 'creates a sample of data points from a json file' do
        parsed_json_data = [{ "date" => "2014-03-20", "cohort" => "B", "result" => 0 }]
        conversion_test.import_data(parsed_json_data)
        expect(conversion_test.sample.data_points.size).to eq(1)
      end
    end
  end
end
