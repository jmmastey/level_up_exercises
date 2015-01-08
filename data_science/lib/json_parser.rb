require 'json'
require 'abanalyzer'

class JsonParser
  attr_reader :parsed_a_b_data, :json_length

  def initialize(json)
    @parsed_a_b_data = parse_and_split(json)
  end

  private

  def parse_and_split(json)
    data = JSON.parse(File.read(json), symbolize_names: true)
    @json_length = data.length
    { a:
      {
        pass: data.count { |hash| hash.value?("A") && hash[:result] == 1 },
        fail: data.count { |hash| hash.value?("A") && hash[:result] == 0 },
      },
      b:
      {
        pass: data.count { |hash| hash.value?("B") && hash[:result] == 1 },
        fail: data.count { |hash| hash.value?("B") && hash[:result] == 0 },
      },
  }
  end
end

JsonParser.new("source_data.json")
