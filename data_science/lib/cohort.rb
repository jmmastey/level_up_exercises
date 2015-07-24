class Cohort
  attr_accessor :name, :visits

  def initialize(name)
    @name = name
    @visits = []
  end

  def add_visit(visit)
    @visits << visit
  end

  def conversions
    visits.count(&:conversion?)
  end

  def failed_conversions
    visits.reject(&:conversion?).length
  end

  def sample_size
    return visits.length
  end

  def conversion_rate
    conversions.to_f / sample_size.to_f
  end

  def standard_error
    rate = conversion_rate
    size = sample_size
    Math.sqrt((rate * (1 - rate)) / size)
  end

  def conversion_rate_range
    [conversion_rate - standard_error,
     conversion_rate + standard_error]
  end

  def generate_pass_fail_info
    {
      pass: conversions,
      fail: failed_conversions
    }
  end
end
