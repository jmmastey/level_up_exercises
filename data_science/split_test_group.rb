class SplitTestGroup
  attr_reader :name, :conversions, :views

  CONFIDENCE_STD_ERROR_FACTOR = 1.96

  def initialize(data)
    @name = data[:name]
    @conversions = data[:conversions]
    @views = data[:views]
  end

  def conversion_rate
    @conversion_rate ||= @conversions.to_f / @views
  end

  def conversion_rate_error
    unless @conversion_rate_error
      standard_error = Math.sqrt(conversion_rate * (1 - conversion_rate) / @views)
      @conversion_rate_error = CONFIDENCE_STD_ERROR_FACTOR * standard_error
    end

    @conversion_rate_error
  end

  def conversion_rate_range
    unless @conversion_rate_range
      min = conversion_rate - conversion_rate_error
      max = conversion_rate + conversion_rate_error
    end

    @conversion_rate_range = [min, max]
  end
end
