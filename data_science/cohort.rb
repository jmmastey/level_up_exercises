class Cohort
  attr_reader :name

  def initialize(data, name)
    @data = data
    @name = name
  end

  def size
    @data.size
  end

  def conversions
    @data.count do |result|
      result["result"] == 1
    end
  end

  def conversion_percentage
    conversions.to_f / size.to_f
  end

  def standard_error
    p = conversion_percentage
    n = size
    (Math.sqrt(p * (1 - p) / n))
  end
end
