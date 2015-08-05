require 'abanalyzer'
require_relative 'data_set'
require_relative 'cohort'

class RoboResearcher
  attr_accessor :cohorts

  def initialize(data_file: nil)
    @cohorts = []
    data = DataSet.new(file_name: data_file)
    populate_cohorts(data)
  end

  def populate_cohorts(data)
    data.cohorts.each do |name|
      views = data.views(name)
      conversions = data.conversions(name)
      @cohorts << Cohort.new(name: name, views: views, conversions: conversions)
    end
  end

  def significant?
    significance_of_difference >= 95.0
  end

  def significance_of_difference
    cohort0 = { yes: cohorts[0].conversions, no: cohorts[0].non_conversions }
    cohort1 = { yes: cohorts[1].conversions, no: cohorts[1].non_conversions }
    test = ABAnalyzer::ABTest.new(cohorts[0].name => cohort0,
                                  cohorts[1].name => cohort1)
    p = test.chisquare_p
    p_to_percentage(p)
  end

  def p_to_percentage(p)
    (1 - p) * 100
  end

  def best_cohort
    rate0 = cohorts[0].conversion_rate_midpoint
    rate1 = cohorts[1].conversion_rate_midpoint
    rate0 > rate1 ? cohorts[0] : cohorts[1]
  end

  def to_s
    cohorts.map(&:to_s)
  end

  def cohort(name)
    cohorts.find { |c| c.name == name }
  end
end
