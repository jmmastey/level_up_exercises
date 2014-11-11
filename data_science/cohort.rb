class Cohort
  attr_reader :name

  def initialize(name)
    raise ArgumentError unless name.is_a? String
    @name = name
    @results = { success: 0, failure: 0 }
  end

  def size
    @results[:success] + @results[:failure]
  end

  def success_ratio
    return 0.00 if size == 0
    @results[:success].to_f / size
  end

  def add_successes(num)
    @results[:success] += num
  end

  def add_failures(num)
    @results[:failure] += num
  end

  def [](key)
    @results[key]
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
