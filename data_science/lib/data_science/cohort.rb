class DataScience::Cohort
  attr_reader :conversions, :name, :trials

  def initialize(name)
    @name = name

    @conversions = 0
    @trials      = 0
  end
  
  def add_sample(converted=false)
    @trials += 1
    
    if converted
      @conversions += 1
    end
  end
end
