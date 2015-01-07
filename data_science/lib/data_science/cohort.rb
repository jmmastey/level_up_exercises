class DataScience::Cohort
  attr_reader :conversion_rate, :conversions, :name, :trials

  def initialize(name)
    @name = name

    @conversions = 0
    @trials      = 0
  end
  
  def add_sample(sample)
    @trials = @trials + 1
    
    if sample.to_i > 0
      @conversions = @conversions + 1
    end
    
    calculate_conversion_rate
  end
  
  def standard_error
    # Square root of (p * (1-p) / n)

    (Math.sqrt(@conversion_rate * (1 - @conversion_rate)/ @trials)).round(3)
  end
  

private
  
  def calculate_conversion_rate
    @conversion_rate = (@conversions.to_f/@trials.to_f).round(3)
  end
end
