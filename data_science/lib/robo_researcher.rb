require_relative 'data_set'
require_relative 'cohort'

class RoboResearcher
  attr_accessor :cohorts
  attr_reader :data

  def initialize(data_file: nil)
    @cohorts = []
    @data = DataSet.new(file_name: data_file)
    data.cohorts.each do |name|
      @cohorts << Cohort.new(name, data.views(name), data.conversions(name))
    end
  end

  def conclude
    count = cohorts.length
    return "Unable to compare #{count} cohorts." unless count == 2
    significance = cohorts[0].significance_of_difference(cohorts[1])
    return conclude_significant(significance) unless significance < 95.0
    "There is no significant difference between cohorts."
  end

  def conclude_significant(significance)
    best = cohorts[0].better_than?(cohorts[1]) ? cohorts[0] : cohorts[1]
    standardized_significance = stats_standard_significance(significance)
    "Cohort #{best.name} is better with 95% confidence.  The difference is " \
    "significant with #{standardized_significance}% confidence."
  end

  def stats_standard_significance(significance)
    return 99.99 if significance >= 99.99
    return 99.9 if significance >= 99.9
    return 99 if significance >= 99
    significance.round
  end

  def details
    cohorts.map(&:to_s)
  end
end
