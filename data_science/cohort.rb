class Cohort
  attr_accessor :name, :sample_size, :conversions, :conversion_rate
  attr_accessor :stnd_error, :lower_ci, :upper_ci
  COND_LEVEL = 1.96

  def initialize(name, sample)
    @name = name
    @sample_size = sample.count
    @conversions = sample.count(1)
  end

  def calculate_statistics
    calc_conversion_rate
    calc_standard_error
    calc_confidence_intervals
  end

  def calc_conversion_rate
    @conversion_rate = @conversions.to_f / @sample_size
  end

  def calc_confidence_intervals
    @lower_ci = @conversion_rate - COND_LEVEL * @stnd_error
    @upper_ci = @conversion_rate + COND_LEVEL * @stnd_error
  end

  def calc_standard_error
    p = @conversion_rate
    n = @sample_size
    @stnd_error = Math.sqrt(p * (1 - p) / n)
  end

  def conversion_statistics
    { conversions: @conversions, non_conversions: @sample_size - @conversions }
  end

  def print_summary
    puts "Cohort: #{@name}"
    print "Conversion Rate: #{@conversion_rate.round(4)}"
    puts " (#{@conversions} out of #{@sample_size} visits)"
    puts "95% Confidence Interval: [#{lower_ci.round(4)}, #{upper_ci.round(4)}]"
    puts
  end
end
