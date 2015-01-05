require 'json'
require 'abanalyzer'

class JsonParser
  attr_accessor :data_hash

  def initialize(json)
    @data_hash = parse_and_split(json)
    # puts @data_hash.group_by { |k, v| k == "cohort" and v == "A"  }
    #puts @data_hash

    tester = ABAnalyzer::ABTest.new @data_hash
    #puts tester.different?

  end

  private

  def parse_and_split(json)
    data = JSON.parse(File.read(json))
    { a_group: {
      pass: data.count { |hash| hash.value?("A") and hash["result"] == 1 },
      fail: data.count { |hash| hash.value?("A") and hash["result"] == 0 },
    },
    b_group: {
      pass: data.count { |hash| hash.value?("B") and hash["result"] == 1 },
      fail: data.count { |hash| hash.value?("B") and hash["result"] == 0 },
  }
  }
  end
end

#JsonParser.new("../source_data.json")
