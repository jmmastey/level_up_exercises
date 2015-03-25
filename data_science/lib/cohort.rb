class Cohort
  CONFIDENCE_MULTIPLIER = 1.96
  DECIMAL_PLACES = 4
  attr_accessor :conversions, :non_conversions
  def initialize(data = [])
    @conversions = 0
    @non_conversions = 0
    process_data(data)
  end

  def process_data(data)
    data.each do |record|
      record["result"] == 1 ? @conversions += 1 : @non_conversions += 1
    end
  end

  def total_sample_size
    @conversions + @non_conversions
  end

  def conversion_rate
    rate = conversions.to_f / total_sample_size
    rate.round(DECIMAL_PLACES)
  end

  def std_err(p)
    se = Math.sqrt(p * (1 - p) / total_sample_size)
    se.round(DECIMAL_PLACES)
  end

  def error_bars
    se = std_err(conversion_rate)
    delta = se * CONFIDENCE_MULTIPLIER
    pos_error_bar = (conversion_rate + delta).round(DECIMAL_PLACES)
    neg_error_bar = (conversion_rate - delta).round(DECIMAL_PLACES)
    [pos_error_bar, neg_error_bar]
  end

  def to_s
    "conversions: #{conversions}\n" \
    "non_conversions: #{non_conversions}\n" \
    "sample size: #{total_sample_size}\n" \
    "conversion_rate: #{conversion_rate}\n"
  end
end
