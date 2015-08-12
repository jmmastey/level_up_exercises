class Cohort
  attr_accessor :name, :sample_size, :conversions

  def initialize(name, samples)
    @name = name
    @sample_size = samples.length
    @conversions = samples.count(1)
  end

  def calculate_conversion_rate
    @conversions.to_f / @sample_size
  end

  def calculate_standard_error
    p = calculate_conversion_rate
    n = @sample_size.to_f
    Math.sqrt(p * (1 - p) / n)
  end

  def calculate_confidence_interval
    lower_limit = calculate_conversion_rate - calculate_standard_error
    upper_limit = calculate_conversion_rate + calculate_standard_error
    [lower_limit, upper_limit]
  end

  def conversion_stats
    { converts: @conversions, nonconverts: @sample_size - @conversions }
  end

  def print_info
    puts "Cohort: #{@name}"
    puts "Sample Size: #{@sample_size}"
    puts "Conversions: #{@conversions}"
    puts "Conversion Rate #{calculate_conversion_rate}"
    puts "Confidence Interval #{calculate_confidence_interval}"
    puts
  end
end
