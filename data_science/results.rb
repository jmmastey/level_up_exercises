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
    cohorts.each do |_, cohort|
      sprintf("%s  %d  %d  %f  %f" , cohort.name, cohort.non_conversions,
              cohort.conversions, cohort.visitors, cohort.conversion_rate)
    end
  end

  private

  def parse_file
    file = File.read filename
    input = JSON.parse file
    input.each do |data|
      @data_points << DataPoint.new(data["cohort"], data["result"])
      @cohorts[data["cohort"]] = nil
    end
  end

  def gather_data_into_cohorts
    cohorts_orig = cohorts
    cohorts_orig.each do |cohort, _|
      @cohorts[cohort] = Cohort.new(
        cohort,
        conversions: num_conversions(cohort, convert: true),
        non_conversions: num_conversions(cohort, convert: false))
    end
  end

  def num_conversions(cohort, options = {})
    data_points.count do |data_point|
      data_point.cohort_convert?(cohort, options[:convert])
    end
  end
end
