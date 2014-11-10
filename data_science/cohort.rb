class Cohort
  attr_reader :name, :num_converts, :num_non_converts

  def initialize(name)
    raise ArgumentError unless name.is_a? String
    @name = name
    @num_converts = 0
    @num_non_converts = 0
  end

  def size
    @num_converts + @num_non_converts
  end

  def conversion_ratio
    return 0.00 if size == 0
    @num_converts * 1.00 / size 
  end

  def add_converts(num)
    @num_converts += num
  end

  def add_non_converts(num)
    @num_non_converts += num
  end

  def standard_error
    return 0.00 if size == 0
    Math.sqrt(conversion_ratio * (1 - conversion_ratio) / size)
  end

  def confidence_interval
    fluctuation = 1.96 * standard_error
    [conversion_ratio - fluctuation, conversion_ratio + fluctuation]
  end
end