require_relative '../lib/data_science/conversion_test'

conversion_test = ConversionTest.new("A_B_Test")

data_file = ARGV.shift || File.join(File.dirname(__FILE__), 'source_data.json')

json_file = JsonParser.parse_file(data_file)
