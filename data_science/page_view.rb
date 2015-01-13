class PageView
  attr_reader :cohort, :result

  def initialize(cohort, result)
    @cohort = cohort
    @result = result
  end

  def converted?
    result == 1
  end

  def rejected?
    result == 0
  end
end
