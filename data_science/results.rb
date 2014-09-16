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
  end

  def print_results
    puts "Cohort      Non-conv     Conv     Visitors    Rate"
    cohorts.each do |name, cohort|
      sprintf("%s  %d  %d  %f  %f" , cohort.name, cohort.non_conversions, cohort.conversions, cohort.visitors, cohort.conversion_rate)
    end
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
    cohorts_orig = cohorts
    cohorts_orig.each do |cohort, _|
      @cohorts[cohort] =
        Cohort.new(cohort,
        conversions: num_conversions(cohort, true),
        non_conversions: num_conversions(cohort, false))
    end
  end

  def num_conversions(cohort, converted)
    data_points.count do |data_point|
      data_point.cohort_convert?(cohort, converted)
    end
  end
end
