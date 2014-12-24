class Cohort
  attr_accessor :name, :pageviews

  def initialize(name, pageviews)
    @name = name
    @pageviews = pageviews
  end

  def conversion_rate
    positive_conversions.to_f/cohort_views.to_f
  end

  def standard_error
    Math.sqrt((conversion_rate*(1-conversion_rate)/cohort_views))
  end

  #number data points that result 1 and cohort A
  def positive_conversions
    @pageviews.select { |view| view.result == 1 }.size
  end

  def negative_conversions
    @pageviews.select { |view| view.result == 0 }.size
  end

  def cohort_views
    pageviews.size
  end
end
