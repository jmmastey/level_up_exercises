require 'bigdecimal'

class Cohort
  attr_accessor :name, :sample_size, :conversions, :conversion_rate,
    :standard_error, :lower_confidence_interal,
    :upper_confidence_interval

  CONFIDENCE_LEVEL = BigDecimal(1.96, 4)

  def initialize(name, sample)
    @name = name
    @sample_size = BigDecimal(sample.count)
    @conversions = BigDecimal(sample.count(1))
  end

  def calculate_statistics
    calculate_conversion_rate
    calculate_standard_error
    calculate_confidence_intervals
  end

  def calculate_conversion_rate
    @conversion_rate = @conversions / @sample_size
  end

  def calculate_confidence_intervals
    difference = CONFIDENCE_LEVEL * @standard_error
    @lower_confidence_interal = @conversion_rate - difference
    @upper_confidence_interval = @conversion_rate + difference
  end

  def calculate_standard_error
    p = @conversion_rate
    n = @sample_size
    @standard_error = BigDecimal(Math.sqrt(p * (1 - p) / n), 8)
  end

  def conversion_statistics
    { conversions: @conversions, non_conversions: @sample_size - @conversions }
  end

  def print_big_decimal(decimal)
    format('%.4f', decimal)
  end

  def print_summary
    puts "Cohort: #{@name}"
    print "Conversion Rate: #{print_big_decimal(@conversion_rate)}"
    puts " (#{@conversions.to_i} out of #{@sample_size.to_i} visits)"
    puts "95% Confidence Interval: " \
         "[#{print_big_decimal(lower_confidence_interal)}, " \
         "#{print_big_decimal(upper_confidence_interval)}]"
    puts
  end
end
