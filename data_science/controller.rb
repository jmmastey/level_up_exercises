require_relative 'cohort'
require_relative 'loader'

class Controller
  attr_accessor :cohorts

  def initialize(filename)
    run(filename)
    @cohorts = []
  end

  def run(filename)
    views = parse(filename)
    names = unique_cohort_names(views)
    create_empty_cohorts(names)
  end

  def parse(filepath)
    JSON.parse(File.read(filepath))
  end

  def unique_cohort_names(views)
    views.map { |view| view['cohort'] }.uniq
  end

  def create_empty_cohorts(names)
    @cohorts = names.map do |name|
      Cohort.new(name)
    end
  end

  def sort_views_into_cohorts()
    views.each do |view|
      require 'pry'; binding.pry
      view += cohorts[view["cohort"]
    end
  end
end

  # count = 0
  #  a_positives = 0
  #  a_views = 0

  #  views.each do |view|
  #    count += 1
  #    a_positives += 1 if (view["result"] == 1 && view["cohort"] =="A")
  #    a_views += 1 if (view["cohort"] =="A")
  #  end

  #  puts count
  #  puts a_positives
  #  puts a_views


  #  # p is conversion rate
  #  puts p = (a_positives.to_f/a_views.to_f)

  #  puts standard_error = Math.sqrt((p*(1-p)/a_views))

  #  puts sigmas = 1.96 * standard_error
  #  puts confidence_interval_lower = p - sigmas
  #  puts confidence_interval_higher =  p + sigmas

  # create a cohort object
  # parse_json
  # calculate_conversion_percentage
  # calculate_confidence_level
  # report

controller = Controller.new('test.json')
