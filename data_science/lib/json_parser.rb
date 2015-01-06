require 'json'
require 'abanalyzer'

class JsonParser
  attr_accessor :parsed_ab_data, :json_length

  def initialize(json)
    @parsed_ab_data = parse_and_split(json)
    # puts @data_hash.group_by { |k, v| k == "cohort" and v == "A"  }
    # puts @data_hash

    # tester = ABAnalyzer::ABTest.new @data_hash
    # puts tester.different?
  end

  private

  def parse_and_split(json)
    data = JSON.parse(File.read(json), symbolize_names: true)
    @json_length = data.length
    { a_group: {
      pass: data.count { |hash| hash.value?("A") && hash[:result] == 1 },
      fail: data.count { |hash| hash.value?("A") && hash[:result] == 0 },
    },
    b_group: {
      pass: data.count { |hash| hash.value?("B") && hash[:result] == 1 },
      fail: data.count { |hash| hash.value?("B") && hash[:result] == 0 },
    },
  }
  end
end

JsonParser.new("source_data.json")
