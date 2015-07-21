class Cohort
  attr_reader :success_count
  attr_reader :failure_count

  def initialize(success_count, failure_count)
    @success_count = success_count
    @failure_count = failure_count
  end

  def total_sample_size
    @success_count + @failure_count
  end
end
