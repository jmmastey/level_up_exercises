require 'abanalyzer'

class Cohort
  attr_accessor :name, :views, :conversions
  attr_reader :conversion_rate_interval

  INTERVAL_CONFIDENCE = 0.95

  def initialize(name, views, conversions)
    @name = name
    @views = views
    @conversions = conversions
  end

  def conversion_rate_interval
    return 0 if views == 0
    ABAnalyzer.confidence_interval(conversions, views, INTERVAL_CONFIDENCE)
  end

  def better_than?(other)
    interval_midpoint > other.interval_midpoint
  end

  def interval_midpoint
    (conversion_rate_min + conversion_rate_max) / 2
  end

  def conversion_rate_min
    conversion_rate_interval[0]
  end

  def conversion_rate_max
    conversion_rate_interval[1]
  end

  def significance_of_difference(other)
    cohort = { yes: conversions, no: views - conversions }
    other_cohort = { yes: other.conversions,
                     no: other.views - other.conversions }
    test = ABAnalyzer::ABTest.new(name => cohort, other.name => other_cohort)
    p = test.chisquare_p
    p_to_percentage(p)
  end

  def p_to_percentage(p)
    (1 - p) * 100
  end

  def to_s
    "#{readable_basic_data}  #{readable_conversion_rate}"
  end

  def readable_basic_data
    "Cohort #{name} contains #{views} samples with #{conversions} conversions."
  end

  def readable_conversion_rate
    "The conversion rate is #{conversion_rate_min_percent}% - " \
    "#{conversion_rate_max_percent}% with a 95% confidence."
  end

  def conversion_rate_min_percent
    (conversion_rate_min * 100).round
  end

  def conversion_rate_max_percent
    uncapped_percentage = (conversion_rate_max * 100).round
    [uncapped_percentage, 100].min
  end
end
