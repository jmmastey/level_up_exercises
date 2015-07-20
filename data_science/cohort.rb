class Cohort
  attr_accessor :name, :sample_size, :conversions
  
  def initialize(name, samples)
    @name = name
    @sample_size = samples.length
    @conversions = samples.count(1)
  end

  def calculate_conversion_rate
    @conversions.to_f / @sample_size
  end

  def calculate_standard_error
    p = calculate_conversion_rate
    n =  @sample_size.to_f
    Math.sqrt(p * (1 - p) / n)
  end
end