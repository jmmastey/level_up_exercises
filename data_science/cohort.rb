require 'abanalyzer'

class Cohort

  CONFIDENCE = 0.95

  attr_accessor :name, :pageviews

  def initialize(name, pageviews)
    @name = name
    @pageviews = pageviews
  end

  def conversions
    @pageviews.select { |view| view.result == 1 }.size
  end

  def rejections
    @pageviews.select { |view| view.result == 0 }.size
  end

  def size
    pageviews.size
  end

  def to_s
    "Converion percentage was #{conversion_percentage} within a 95% confidence interval of #{confidence_interval}"
  end

  def conversion_percentage
    conversions.to_f / size.to_f
  end

  def confidence_interval
    ABAnalyzer.confidence_interval(conversions, size, CONFIDENCE)
  end

  def standard_error
    p = conversion_percentage
    n = size
    (Math.sqrt(p * (1 - p) / n))
  end
end
