require_relative '../lib/data_science/conversion_test'
require_relative '../lib/data_science/json_parser'

conversion_test = ConversionTest.new("A_B_Test")

data_file = ARGV.shift || File.join(File.dirname(__FILE__), "source_data.json")

json_data = JsonParser.parse_file(data_file)

conversion_test.import_json_data(json_data)

conversion_test.print_statistical_results("A", "B")
