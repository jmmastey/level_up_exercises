require 'abanalyzer'
class Cohort
  CONFIDENCE = 0.95
  attr_accessor :name, :pageviews

  #instead of array page view objects

  def initialize(name, pageviews)
    @name      = name
    @pageviews = pageviews
  end

  def conversions
    pageviews.count(&:converted?)
  end

  def rejections
    pageviews.count {  |view| view.rejected? }
  end

  def size
    pageviews.size
  end

  def to_s
    "Conversion %: #{conversion_percentage} within 95% confidence interval of #{confidence_interval}"
  end

  def conversion_percentage
    conversions.to_f / size.to_f
  end

  def confidence_interval
    ABAnalyzer.confidence_interval(conversions, size, CONFIDENCE)
  end

  def standard_error
    Math.sqrt(conversion_percentage * (1 - conversion_percentage) / size)
  end

end
