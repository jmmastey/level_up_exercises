require 'abanalyzer'

class Cohort
  attr_accessor :name, :views, :conversions
  attr_reader :conversion_rate_interval

  INTERVAL_CONFIDENCE = 0.95

  def initialize(name:, views:, conversions:)
    bad_numeric_arg_raise("views") if bad_numeric_arg?(views)
    bad_numeric_arg_raise("conversions") if bad_numeric_arg?(conversions)
    @name = name
    @views = views
    @conversions = conversions
  end

  def bad_numeric_arg_raise(arg_name)
    raise(ArgumentError, "#{arg_name} must be a non-negative integer")
  end

  def bad_numeric_arg?(arg_value)
    return true if arg_value.nil?
    return true unless arg_value.respond_to?(:round)
    return true if arg_value < 0
    return true unless arg_value.round == arg_value
  end

  def conversion_rate_interval
    return [0, 0] if views == 0
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
    name_string = name.nil? ? "Nameless cohort" : "Cohort #{name}"
    "#{name_string} contains #{views} samples with #{conversions} " \
    "conversions.  The conversion rate is #{conversion_rate_min} - " \
    "#{conversion_rate_max} with a 95% confidence."
  end
end
