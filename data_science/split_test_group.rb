class SplitTestGroup
  attr_reader :name, :conversions, :views

  CONFIDENCE_STD_ERROR_FACTOR = 1.96

  def initialize(data)
    @name = data[:name]
    @conversions = data[:num_conversions]
    @views = data[:num_views]
  end

  def conversion_rate
    # check for @views == 0
    @conversion_rate ||= @conversions.to_f / @views
  end

  def conversion_rate_error
    unless @conversion_rate_error
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

  private

  def standard_error
    Math.sqrt(conversion_rate * (1 - conversion_rate) / @views)
  end
end
