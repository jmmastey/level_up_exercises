class DataScience::Cohort
  attr_reader :conversions, :name, :trials

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
  end
end
