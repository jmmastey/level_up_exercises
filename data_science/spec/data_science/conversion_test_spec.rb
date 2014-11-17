require 'data_science/conversion_test'
require 'data_science/json_parser'
require 'pry'

module DataScience
  describe ConversionTest do
    let(:conversion_test) { ConversionTest.new }

    it 'has two cohorts' do
      expect(conversion_test.control_group.type).to eq("A")
      expect(conversion_test.test_group.type).to eq("B")
    end

    it 'adds data points to each the control group cohort' do
      parsed_json_data = [{ "date" => "2014-03-20", "cohort" => "A", "result" => 0 }]
      conversion_test.import_data(parsed_json_data)
      expect(conversion_test.control_group.visits.size).to eq(1)
    end

    it 'adds data points to each the test group cohort' do
      parsed_json_data = [{ "date" => "2014-03-20", "cohort" => "B", "result" => 0 }]
      conversion_test.import_data(parsed_json_data)
      expect(conversion_test.test_group.visits.size).to eq(1)
    end
  end
end
