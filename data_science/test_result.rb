class TestResult
  attr_accessor :cohort, :date, :result
  def initialize(cohort, date, result)
    @cohort = cohort
    @date = date
    @result = result
  end
end
