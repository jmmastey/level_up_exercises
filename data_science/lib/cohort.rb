include Math

class Cohort
  attr_reader :conversions, :nonconvs
  def initialize(conversions, nonconvs)
    validate_params(conversions, nonconvs)
    @conversions = conversions
    @nonconvs = nonconvs
  end

  def total_trials
    @conversions + @nonconvs
  end

  def conversion_rate
    (@conversions.to_f / total_trials).round(6)
  end

  def standard_error
    (sqrt(conversion_rate * (1 - conversion_rate) / total_trials)).round(6)
  end

  def conversion_range
    Range.new(
      (conversion_rate - 1.96 * standard_error).round(6),
      (conversion_rate + 1.96 * standard_error).round(6),
    )
  end

  def to_s
    "Conversions: #{conversions}\nNon-conversions #{nonconvs}\n" \
    "Total trials: #{total_trials}\nConversion rate: #{conversion_rate}\n" \
    "Standard error: #{standard_error}\nConversion range: #{conversion_range}"
  end

  private

  def validate_params(conversions, nonconvs)
    raise TypeError unless conversions.is_a?(Fixnum) && nonconvs.is_a?(Fixnum)
    raise ArgumentError if conversions < 0 || nonconvs < 0
    raise ArgumentError unless (conversions + nonconvs) > 0
  end
end
