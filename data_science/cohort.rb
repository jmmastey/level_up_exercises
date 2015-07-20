class Cohort
  attr_accessor :name, :sample_size, :conversions
  
  def initialize(name, samples)
    @name = name
    @sample_size = samples.length
  end
end