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
end