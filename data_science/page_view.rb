class PageView
  attr_reader :cohort, :result

  def initialize(cohort, result)
    @cohort = cohort
    @result = result
  end
end