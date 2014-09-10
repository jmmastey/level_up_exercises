class SplitTestGroup
  attr_reader :conversions, :views, :conversion_rate, :conversion_rate_interval

  CONFIDENCE_STD_ERROR_FACTOR = 1.96

  def initialize(data)
    @conversions = data[:conversions]
    @views = data[:views]

    perform_calculations
  end

  private

  def perform_calculations
    calculate_conversion_rate
    calculate_conversion_rate_interval
  end

  def calculate_conversion_rate
    @conversion_rate = @conversions.to_f / @views
  end

  def calculate_conversion_rate_interval
    standard_error = Math.sqrt(@conversion_rate * (1 - @conversion_rate) / @views)
    @conversion_rate_interval = CONFIDENCE_STD_ERROR_FACTOR * standard_error
  end
end
