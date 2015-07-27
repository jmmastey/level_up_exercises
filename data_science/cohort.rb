require 'abanalyzer'

class Cohort
  attr_accessor :conversions, :sample_size, :name

  def initialize(name, samples)
    @name = name
    @sample_size = samples.count
    @conversions = calc_conversions(samples)
  end

  def conversion_hash
    {
      converted: conversions,
      not_converted: sample_size - conversions
    }
  end

  def conversion_rate
    conversions.to_f / sample_size.to_f
  end

  def standard_error
    numerator = conversion_rate * (1 - conversion_rate)
    Math.sqrt(numerator / sample_size)
  end

  def confidence_interval
    low = conversion_rate - 1.96 * standard_error
    high = conversion_rate + 1.96 * standard_error

    { low: low.round(3), high: high.round(3) }
  end

  def to_s
    str = "======== Cohort #{@name} ========\n"
    str << "#{report_conversions}\n"
    str << "#{report_sample_size}\n"
    str << "#{report_conversion_rate}\n"
    str << "#{report_standard_error}\n"
    str << "#{report_confidence}\n"
  end

  private

  def report_conversions
    "Conversions:\t\t#{conversions}"
  end

  def report_sample_size
    "Sample Size:\t\t#{sample_size}"
  end

  def report_conversion_rate
    rate = (conversion_rate * 100).round(2)
    "Conversion Rate:\t#{rate}%"
  end

  def report_standard_error
    "Standard Error:\t\t#{standard_error}"
  end

  def report_confidence
    ci = confidence_interval

    str = "95% Confidence Interval for Cohort #{name}:\n"
    str << "[#{ci[:low]}, #{ci[:high]}]"
  end

  def calc_conversions(samples)
    samples.count { |sample| sample['result'] == 1 }
  end
end
