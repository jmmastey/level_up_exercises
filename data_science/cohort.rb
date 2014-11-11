class Cohort
  attr_reader :name, :num_successes, :num_failures

  def initialize(name)
    raise ArgumentError unless name.is_a? String
    @name = name
    @num_successes = 0
    @num_failures = 0
  end

  def size
    @num_successes + @num_failures
  end

  def success_ratio
    return 0.00 if size == 0
    @num_successes.to_f / size 
  end

  def add_successes(num)
    @num_successes += num
  end

  def add_failures(num)
    @num_failures += num
  end

  def standard_error
    return 0.00 if size == 0
    Math.sqrt(success_ratio * (1 - success_ratio) / size)
  end

  def confidence_interval
    sigma = 1.96 * standard_error
    [success_ratio - sigma, success_ratio + sigma]
  end
end