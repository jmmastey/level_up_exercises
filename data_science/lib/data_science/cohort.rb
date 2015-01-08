class DataScience::Cohort
  attr_reader :conversion_rate, :conversions, :name, :trials

  def initialize(name)
    @name        = name
    @conversions = 0
    @trials      = 0
  end

  def add_sample(sample)
    @trials += 1

    if sample.to_i > 0
      @conversions += 1
    end

    calculate_conversion_rate
  end

  def conversion_as_percentage
    (@conversion_rate * 100).round(3)
  end

  # TODO: rename confidence_interval or some such?
  def range_for_conversion
    (standard_error * 1.98).round(3)
  end

  def range_with_confidence_interval
    "#{conversion_as_percentage}% ± #{range_for_conversion}"
  end

  def standard_error
    (Math.sqrt(@conversion_rate * (1 - @conversion_rate) / @trials)).round(3)
  end

  private

  def calculate_conversion_rate
    @conversion_rate = (@conversions.to_f / @trials.to_f).round(3)
  end
end
