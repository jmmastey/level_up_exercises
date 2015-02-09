require 'json'
class TestDataList
  TestResult = Struct.new(:cohort, :date, :result)
  attr_accessor :data

  def initialize(filepath)
    @data = []
    raise "File Not Found!" unless File.exist?(filepath)

    json_data = JSON.parse(File.read(filepath))
    json_data.each do |result|
      data.push(TestResult.new(result['cohort'], result['date'], result['result']))
    end
  end
end
