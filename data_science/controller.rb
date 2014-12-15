require_relative 'cohort'
require_relative 'loader'


class Controller
  attr_accessor :cohort

  def initialize(filename)
    run(filename)
  end

  def run(filename)
    views = load_views(filename)
    #require 'pry'; binding.pry

    count = 0
    a_positives = 0
    b_positives = 0
    a_views = 0
    b_views = 0

    views.each do |view|
      count += 1
      a_positives += 1 if (view["result"] == 1 && view["cohort"] =="A")
      b_positives += 1 if (view["result"] == 1 && view["cohort"] =="B")
      a_views += 1 if (view["cohort"] =="A")
      b_views += 1 if (view["cohort"] =="B")
    end

    puts count
    puts a_positives
    puts b_positives
    puts a_views
    puts b_views

    # p is conversion rate
    puts p = (a_positives.to_f/a_views.to_f)

    puts standard_error = Math.sqrt((p*(1-p)/a_views))

    puts sigmas = 1.96 * standard_error
    puts confidence_interval_lower = p - sigmas
    puts confidence_interval_higher =  p + sigmas 

    # create a cohort object
    # parse_json
    # calculate_conversion_percentage
    # calculate_confidence_level
    # report
  end

  def load_views(filename)
    Loader.new(filename).parse
  end

  def create_cohort(views)


  end
end

controller = Controller.new('source_data.json')
