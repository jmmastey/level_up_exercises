require 'abanalyzer'
require_relative 'data_set'
require_relative 'cohort'

class BadData < StandardError
end

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
    test = create_abtest
    p = test.chisquare_p
    p_to_percentage(p)
  end

  def create_abtest
    raise_if_bad_cohort_count
    ABAnalyzer::ABTest.new(cohorts[0].name => abtest_format(cohorts[0]),
                           cohorts[1].name => abtest_format(cohorts[1]))
  end

  def raise_if_bad_cohort_count
    return if cohorts.length == 2
    raise(BadData, "Need 2 cohorts to compare, but found #{cohorts.length}.")
  end

  def abtest_format(cohort)
    { yes: cohort.conversions, no: cohort.non_conversions }
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
    cohorts.map(&:to_s).join("\n")
  end
end
