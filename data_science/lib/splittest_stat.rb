require 'rubygems'
require 'json'
require_relative 'file_parser'
require_relative 'stat_calculator'
require_relative 'chisquare_calc'

class SplitTestStat
  attr_accessor :totalno, :success, :group_one, :group_two

  def initialize
    @group_one = Hash.new
    @group_two = Hash.new
    json_library = JsonParser.parse("source_data.json")
    cohortize(json_library)
  end

  def cohortize(json_library)
    @group_one[:success] = get_success(json_library, "A")
    @group_one[:totalno] = get_total(json_library, "A")
    @group_two[:success] = get_success(json_library, "B")
    @group_two[:totalno] = get_total(json_library, "B")
  end

  def get_total(parsed_json, cohort)
    parsed_json.count{ |row| row["cohort"]==cohort}
  end

  def get_success(parsed_json, cohort)
    parsed_json.count{ |row| row["cohort"]==cohort && row["result"].to_i==1 }
  end
end

splitteststat = SplitTestStat.new
StatCalculator.new.stat_calculation(splitteststat.group_one)
StatCalculator.new.stat_calculation(splitteststat.group_two)
ChiSquareCalc.calculate(splitteststat.group_one, splitteststat.group_two)

