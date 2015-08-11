class Cohort
  attr_reader :conversions, :fails

  def initialize(name, data)
    @data = data
    @name = name
    @size = sample_size
    @conversions = num_conversions
    @fails = num_fails
  end

  def sample_size
    @data.count { |datum| datum["cohort"] == @name }
  end

  def num_conversions
    @data.count { |datum| datum["cohort"] == @name && datum["result"] == 1 }
  end

  def num_fails
    @data.count { |datum| datum["cohort"] == @name && datum["result"] == 0 }
  end

  def conversion_rate
    rate = @size > 0 ? @conversions.to_f / @size : 0
    rate.round(3)
  end

  def standard_error
    rate = conversion_rate
    se = @size > 0 ? Math.sqrt(rate * (1 - rate) / @size) : 0
    se.round(3)
  end

  def conversion_rate_range
    range_min = conversion_rate - 1.96 * standard_error
    range_max = conversion_rate + 1.96 * standard_error
    range_min = range_min.round(3)
    range_max = range_max.round(3)
    [clamp(range_min), clamp(range_max)]
  end

  def clamp(value)
    if value < 0
      0
    elsif value > 1
      1
    else
      value
    end
  end
end
