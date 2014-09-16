class DataPoint
  attr_reader :cohort, :result

  def initialize(cohort, result)
    raise ArgumentError unless [0, 1].include? result
    @cohort = cohort
    @result = result
  end

  def converted?
    result == 1
  end

  def cohort_convert?(cohort_name, converted)
    cohort_name == cohort && converted == converted?
  end
end
