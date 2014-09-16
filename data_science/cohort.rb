class Cohort
  attr_reader :name, :conversions, :non_conversions, :visitors

  def initialize(name, options = {})
    @name = name
    @conversions = options[:conversions] || 0
    @non_conversions = options[:non_conversions] || 0
    raise ArgumentError unless @conversions.is_a? Integer
    raise ArgumentError unless @non_conversions.is_a? Integer
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
end
