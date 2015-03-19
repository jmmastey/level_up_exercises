class Cohort
  attr_reader :conversions, :non_conversions, :sample_size

  SE_MULTIPLIER = 1.96
  DECIMAL_PLACES = 4

  def initialize(data = [])
    @conversions = 0
    @non_conversions = 0
    parse_data(data)
  end

  def sample_size
    conversions + non_conversions
  end

  def conversion_rate
    conversions.to_f / sample_size
  end

  def error_bars
    delta = standard_error * SE_MULTIPLIER
    low = (conversion_rate - delta).round(DECIMAL_PLACES)
    high = (conversion_rate + delta).round(DECIMAL_PLACES)
    [low, high]
  end

  def to_ab_hash
    { :pos => conversions, :neg => non_conversions }
  end

  def to_s
    "  sample_size     = #{sample_size}\n" \
    "  conversions     = #{conversions}\n" \
    "  non-conversions = #{non_conversions}\n" \
    "  conversion_rate = #{conversion_rate.round(DECIMAL_PLACES)}\n" \
    "  error_bars      = #{error_bars}\n" \
    "\n"
  end

  private

  def standard_error
    p = conversion_rate
    Math.sqrt(p * (1 - p) / sample_size)
  end

  def parse_data(data)
    data.each do |hash|
      result = hash["result"]
      result == 1 ? @conversions += 1 : @non_conversions += 1
    end
  end
end
