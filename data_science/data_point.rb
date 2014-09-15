class DataPoint
  attr_reader :cohort, :result

  def initialize(cohort, result)
    raise ArgumentError unless cohort
    raise ArgumentError unless [0,1].include? result
    @cohort = cohort
    @result = result
  end

  def converted?
    result == 1
  end
end
