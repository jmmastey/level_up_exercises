require "json"

class Results
  attr_reader :filename, :data_points, :cohorts

  def initialize
    @data_points = []
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
      @data_points << DataPoint.new(data["cohort"], data["result"])
      @cohorts[data["cohort"]] = nil # CR? - is there a beter way to do this?
    end
  end

  def gather_data_into_cohorts
    cohorts_temp = {}
    cohorts.each do |cohort_name, _|
      # REFACTOR THIS PLZ
      conversions = num_conversions(cohort_name, true)


      non_conversions = num_conversions(cohort_name, false)

      cohorts_temp[cohort_name] = Cohort.new(cohort_name, conversions: conversions, non_conversions: non_conversions)
    end
    @cohorts = cohorts_temp
  end

  def num_conversions(cohort, converted)
    data_points.select do |data_point|
      data_point.cohort_convert?(cohort, converted)
    end.count
  end

  def num_non_conversions(cohort)
    data_points.select do |data_point|
      data_point.cohort_convert?(cohort, true)
    end.count
  end
end

