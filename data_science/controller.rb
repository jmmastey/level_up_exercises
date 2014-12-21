require_relative 'cohort'

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
      view += cohorts[view["cohort"]]
    end
  end
end



controller = Controller.new('test.json')
