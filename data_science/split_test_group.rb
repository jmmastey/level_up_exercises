class SplitTestGroup
  attr_reader :conversions, :views

  CONFIDENCE_STD_ERROR_FACTOR = 1.96

  def initialize(data)
    @conversions = data[:conversions]
    @views = data[:views]
  end

  def conversion_rate
    @conversion_rate ||= @conversions.to_f / @views
  end

  def conversion_rate_interval
    unless @conversion_rate_interval
      standard_error = Math.sqrt(@conversion_rate * (1 - @conversion_rate) / @views)
      @conversion_rate_interval = CONFIDENCE_STD_ERROR_FACTOR * standard_error
    end

    @conversion_rate_interval
  end

  def conversion_rate_range
    unless @conversion_rate_range
      min = @conversion_rate - @conversion_rate_interval
      max = @conversion_rate + @conversion_rate_interval
    end

    @conversion_rate_range = [min, max]
  end
end
