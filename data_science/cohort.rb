require 'abanalyzer'

class Cohort
  attr_accessor :conversions, :conversion_rate, :standard_error, :sample_size
  attr_accessor :name, :ci_low, :ci_high

  def initialize(samples)
    @name = samples[0]['cohort']
    @sample_size = samples.count
    @conversions = calc_conversions(samples)

    @conversion_rate, @standard_error = calc_mean_error
    @ci_low, @ci_high = calc_confidence_interval
  end

  def conversion_hash
    {
      converted: @conversions,
      not_converted: @sample_size - @conversions
    }
  end

  def report_conversions
    puts "Conversions:\t\t#{@conversions}"
  end

  def report_sample_size
    puts "Sample Size:\t\t#{@sample_size}"
  end

  def report_conversion_rate
    rate = (@conversion_rate * 100).round(2)
    puts "Conversion Rate:\t#{rate}%"
  end

  def report_sample_error
    puts "Standard Error:\t\t#{@standard_error}"
  end

  def report_confidence
    puts "95% Confidence Interval for Cohort #{@name}: "
    puts "[#{@ci_low}, #{@ci_high}]"
  end

  def report_stats
    report_conversions
    report_sample_size
    report_conversion_rate
    report_sample_error
    report_confidence
  end

  def formatted_report
    puts
    puts "======== Cohort #{@name} ========"
    report_stats
    puts
  end

  private

  def calc_confidence_interval
    low = @conversion_rate - 1.96 * @standard_error
    high = @conversion_rate + 1.96 * @standard_error

    [low, high].map { |num| num.round(3) }
  end

  def calc_conversions(samples)
    samples.inject(0) { |sum, data| sum + data['result'] }
  end

  def calc_mean_error
    sample_mean = @conversions.to_f / @sample_size.to_f

    numerator = sample_mean * (1 - sample_mean)
    standard_error = Math.sqrt(numerator / @sample_size)

    [sample_mean, standard_error]
  end
end
