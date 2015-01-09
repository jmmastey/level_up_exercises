require 'json'
require 'abanalyzer'

class JsonParser
  attr_reader :json_length, :a_conv, :a_nonconv, :b_conv, :b_nonconv

  def initialize(json)
    tallied_data = tally_data(parse_and_split(json))
    @a_conv = tallied_data[:a][:pass]
    @a_nonconv = tallied_data[:a][:fai;]
    @b_conv = tallied_data[:b][:pass]
    @b_nonconv = tallied_data[:b][:fail]
  end

  private

  def tally_data(split_data)
    a_data =
      {
        pass: split_data['A'].count { |trial| trial[:result] == 1 },
        fail: split_data['A'].count { |trial| trial[:result] == 0 },
      }
    b_data =
      {
        pass: split_data['B'].count { |trial| trial[:result] == 1 },
        fail: split_data['B'].count { |trial| trial[:result] == 0 },
      }


    { a: a_data, b: b_data }
  end

  def parse_and_split(json)
    data = JSON.parse(File.read(json), symbolize_names: true)
    validate_data(data)
    @json_length = data.length
    data.group_by { |d| d[:cohort] }
  end

  def validate_data(data)

  end
end
