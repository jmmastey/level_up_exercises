require 'abanalyzer'

class Cohort
  attr_accessor :name, :views, :conversions
  attr_reader :conversion_rate_interval

  INTERVAL_CONFIDENCE = 0.95

  def initialize(name:, views:, conversions:)
    @name = name
    @views = views
    @conversions = conversions
  end

  def conversion_rate_interval
    return 0 if views == 0
    ABAnalyzer.confidence_interval(conversions, views, INTERVAL_CONFIDENCE)
  end

  def conversion_rate_midpoint
    (conversion_rate_min + conversion_rate_max) / 2
  end

  def conversion_rate_min
    conversion_rate_interval[0]
  end

  def conversion_rate_max
    conversion_rate_interval[1]
  end

  def non_conversions
    views - conversions
  end

  def to_s
    "Cohort #{name} contains #{views} samples with #{conversions} " \
    "conversions.  The conversion rate is #{conversion_rate_min} - " \
    "#{conversion_rate_max} with a 95% confidence."
  end
end
