class Cohort
  attr_reader :name, :conversions, :non_conversions

  def initialize(name, options = {})
    @name = name
    @conversions = options[:conversions] || 0
    @non_conversions = options[:non_conversions] || 0
    raise ArgumentError unless @conversions.is_a? Integer
    raise ArgumentError unless @non_conversions.is_a? Integer
    raise ArgumentError unless @name.is_a? String
  end

  def add_conversion
    @conversions += 1
  end

  def add_non_conversion
    @non_conversions += 1
  end

  def visitors
    conversions + non_conversions
  end

  def conversion_rate
    conversions.to_f / visitors.to_f
  end
end
