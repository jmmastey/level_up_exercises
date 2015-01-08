require 'json'
require 'abanalyzer'

class JsonParser
  attr_reader :parsed_a_b_data, :json_length

  def initialize(json)
    @parsed_a_b_data = split_data(json)
  end

  private

  def split_data(json)
    data = parse_and_group(json)
    a_data =
      {
        pass: data['A'].count { |trial| trial[:result] == 1 },
        fail: data['A'].count { |trial| trial[:result] == 0 },
      }
    b_data =
      {
        pass: data['B'].count { |trial| trial[:result] == 1 },
        fail: data['B'].count { |trial| trial[:result] == 0 },
      }
    { a: a_data, b: b_data }
  end

  def parse_and_group(json)
    data = JSON.parse(File.read(json), symbolize_names: true)
    @json_length = data.length
    data.group_by { |d| d[:cohort] }
  end
end
