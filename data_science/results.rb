require "json"

class Results
  attr_reader :filename, :data, :cohorts

  def initialize
    @data = []
    @cohorts = {}
  end

  def add_data(filename)
    @filename = filename
    parse_file
    gather_data_into_cohorts
   # puts "cohorts: #{cohorts}"
  end

  private

  def parse_file
    file = File.read filename
    input = JSON.parse file
    input.each do |data|
      @data << DataPoint.new(data["cohort"], data["result"])
      @cohorts[data["cohort"]] = nil # CR? - is there a beter way to do this?
    end
  end

  def gather_data_into_cohorts
    cohorts_temp = {}
    cohorts.each do |cohort_name, _|
      # REFACTOR THIS PLZ
      conversions = data.select{ |data_point| data_point.cohort == cohort_name && data_point.converted? }.count
      
      non_conversions = data.select{ |data_point| data_point.cohort == cohort_name && !data_point.converted? }.count
      cohorts_temp[cohort_name] = Cohort.new(cohort_name, conversions: conversions, non_conversions: non_conversions)
    end
    @cohorts = cohorts_temp
  end
end

