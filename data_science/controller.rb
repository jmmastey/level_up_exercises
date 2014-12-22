require_relative 'cohort'
require_relative 'data_point'
require 'json'

class Controller
  attr_accessor :cohorts

  def initialize(filename)
    run(filename)
    @data_points = []
  end

  def run(filename)
    @data_points = parse(filename)
    names  = unique_cohort_names(@views)
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
      view += cohorts[view["cohort"]]
    end
  end
end