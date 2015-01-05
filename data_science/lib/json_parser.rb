require 'json'

class JsonParser
  attr_accessor :data_hash

  def initialize(json)
    @data_hash = parse_and_split(json)
    # puts @data_hash.group_by { |k, v| k == "cohort" and v == "A"  }
    puts @data_hash
  end

  private

  def parse_and_split(json)
    data = JSON.parse(File.read(json))
    [
    data.count { |hash| hash.value?("A") and hash["result"] == 1 },
    data.count { |hash| hash.value?("A") and hash["result"] == 0 },
    data.count { |hash| hash.value?("B") and hash["result"] == 1 },
    data.count { |hash| hash.value?("B") and hash["result"] == 0 },
  ]
  end
end

JsonParser.new("../source_data.json")
