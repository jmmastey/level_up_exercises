require('abanalyzer')
class Cohort
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

  def confidence_interval
    ABAnalyzer.confidence_interval(conversions, size, confidence)
  end



end
