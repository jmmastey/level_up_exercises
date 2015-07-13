class Cohort
  attr_accessor :conversions, :sample_size, :name
  attr_accessor :ci_low, :ci_mid, :ci_high

  def initialize(samples)
    @name = samples[0]['cohort']
    @sample_size = samples.count
    @conversions = calc_conversions(samples)

    @conversion_rate, @standard_error = calc_mean_error(samples)

    # confidence interval
    @ci_low, @ci_mid, @ci_high = calc_confidence
  end

  def report_conversion_rate
    puts "Conversion Rate:\t#{@conversion_rate}"
  end

  def report_sample_error
    puts "Standard Error:\t\t#{@standard_error}"
  end

  def report_confidence
    puts "95% Confidence Interval for Cohort #{@name}: "
    puts "|(#{@ci_low})--- (#{@ci_mid}) ---(#{@ci_high})|"
  end

  def report_all
    puts
    puts "======== Cohort #{@name} ========"
    report_conversion_rate
    report_sample_error
    puts
    report_confidence
    puts
  end

  private

  def calc_confidence
    low = @conversion_rate - 1.96 * @standard_error
    high = @conversion_rate + 1.96 * @standard_error
    [low, @conversion_rate, high].map { |num| num.round(3) }
  end

  def calc_conversions(samples)
    samples.inject(0) { |sum, data| sum + data['result'] }
  end

  def calc_mean_error(samples)
    sample_mean = @conversions.to_f / @sample_size.to_f

    numerator = sample_mean * (1 - sample_mean)
    standard_error = Math.sqrt(numerator / @sample_size)

    [sample_mean, standard_error]
  end
end
