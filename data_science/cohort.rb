class Cohort
  attr_accessor :name, :visits, :conversions
  STANDARD_DEVIATION = 2 # For 95% confidence rate

  def initialize(data)
    @name = data.keys.first
    @visits = data[@name]["total_visits"]
    @conversions = data[@name]["conversions"]
  end

  def conversion_rate
    return 0 unless visits.nonzero?
    (conversions.to_f / visits).round(4)
  end

  def failures
    visits - conversions
  end

  def standard_error
    Math.sqrt((conversion_rate * (1 - conversion_rate)) / visits).round(4)
  end

  def expected_conversion_rate
    sample_mean = conversion_rate * 100
    { max: (sample_mean + standard_mean).round(2),
      min: (sample_mean - standard_mean).round(2) }
  end

  private

  def standard_mean
    STANDARD_DEVIATION * standard_error
  end

  def conversion_percent
    (conversion_rate * 100.0).round(2)
  end
end
