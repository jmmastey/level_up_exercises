module Binomial
  def success_count
    @data.count(&@result_field)
  end

  def fail_count
    @data.size - success_count
  end

  def success_percent
    success_count.to_f / @data.size
  end

  def fail_percent
    fail_count.to_f / @data.size
  end

  def count
    @data.size
  end

  def to_conf
    ConfidenceInterval.new(
      success_count: success_count,
      fail_count: fail_count,
      confidence_level: 0.95
    )
  end
end
