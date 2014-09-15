class Cohort
  attr_reader :name, :conversions, :non_conversions, :sample_size

  def initialize(name)
    @name = name
    @conversions = 0
    @non_conversions = 0
  end

  def add_conversion
    @conversions += 1
  end

  def add_non_conversion
    @non_conversions += 1
  end

  def sample_size
    conversions + non_conversions
  end
end
