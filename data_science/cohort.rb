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

  private

  def conversion_rate
    conversions.to_f / size.to_f
  end

  def standard_error
    Math.sqrt((conversion_rate*(1-conversion_rate)/size))
  end


end
