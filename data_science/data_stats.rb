class DataStats
  attr_accessor :name, :sample_size, :conversions

  def initialize(name = "", sample_size = 0, conversions = 0)
    @name = name
    @sample_size = sample_size
    @conversions = conversions
  end

  def conversion_percent
    raise ZeroDivisionError if sample_size == 0
    conversions.to_f / sample_size
  end

  def conversion_confidence
    stdv * 1.96
  end

  def to_s
    "#{name} | Sample size - #{sample_size} | Conversions - #{conversions}"
  end

  def ==(other)
    other.class == self.class &&
      other.name == name &&
      other.sample_size == sample_size &&
      other.conversions == conversions
  end

  private

  def stdv
    Math.sqrt(conversion_percent * (1.0 - conversion_percent) / sample_size)
  end
end
