require 'json'
require 'pp'

class Analyzer
  attr_accessor :filename
  def initialize(filename)
    @filename = filename
    @data = JSON.parse(File.read(@filename))
  end

  def parse_data
    group_data = Hash.new { [] }
    @data.each do |r|
      cohort_group = r["cohort"]
      cohort_result = r["result"]
      group_data[cohort_group] <<= cohort_result
    end
    group_data
  end
end
