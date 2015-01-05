class DataScience::Cohort
  attr_reader :name, :trials

  def initialize(name)
    @name   = name
    @trials = 0
  end
  
  def add_sample
    @trials += 1
  end
  
  
end