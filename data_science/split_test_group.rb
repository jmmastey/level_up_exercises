class SplitTestGroup
  attr_reader :name, :conversions, :views

  CONFIDENCE_STD_ERROR_FACTOR = 1.96

  def initialize(data)
    @name = data[:name]
    @conversions = data[:num_conversions]
    @views = data[:num_views]
  end

  def conversion_rate
    return 0 if @views == 0

    @conversion_rate ||= @conversions.to_f / @views
  end

  def conversion_rate_error
    @conversion_rate_error ||= CONFIDENCE_STD_ERROR_FACTOR * standard_error
  end

  def conversion_rate_range
    @conversion_rate_range ||= calculate_conversion_rate_range
  end

  def to_s
    rate = format_pct(conversion_rate)
    error = format_pct(conversion_rate_error)

    %Q(Group #{name}
       #{conversions} conversions from #{views} views
       #{rate} \xc2\xb1 #{error} conversion rate)
  end

  private

  def calculate_conversion_rate_range
    min = conversion_rate - conversion_rate_error
    max = conversion_rate + conversion_rate_error
    [min, max]
  end

  def format_pct(percent)
    "#{sprintf("%.2f", percent * 100)}%"
  end

  def standard_error
    Math.sqrt(conversion_rate * (1 - conversion_rate) / @views)
  end
end
