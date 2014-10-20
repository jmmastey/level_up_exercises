class ABTestCalculator

  ABTestCalculatorResult = 
    Struct.new(:total_visitors_A,
               :conversions_A,
               :total_visitors_B,
               :conversions_B,
               :conversion_ratio_A,
               :standard_error_A,
               :error_margin_A,
               :conversion_ratio_B,
               :standard_error_B,
               :error_margin_B,
               :significant_95_percentile)

  attr_reader :total_visitors_A
  attr_reader :conversions_A

  attr_reader :total_visitors_B
  attr_reader :conversions_B

  STDERRS_95_CONFIDENCE = 1.96

  def initialize
    @total_visitors_A, @conversions_A = 0, 0
    @total_visitors_B, @conversions_B = 0, 0
  end

  def add_visitors_A(n_total, n_positive)
    @total_visitors_A += n_total
    @conversions_A += n_positive
  end

  def add_visitors_B(n_total, n_positive)
    @total_visitors_B += n_total
    @conversions_B += n_positive
  end

  def compute
    r = new_result

    r.total_visitors_A, r.conversions_A = @total_visitors_A, @conversions_A
    r.conversion_ratio_A, r.standard_error_A, r.error_margin_A =
      conversion_stats_for(@conversions_A, @total_visitors_A)

    r.total_visitors_B, r.conversions_B = @total_visitors_B, @conversions_B
    r.conversion_ratio_B, r.standard_error_B, r.error_margin_B =
      conversion_stats_for(@conversions_B, @total_visitors_B)

    compute_significance(r)
  end

  private

  def new_result
    ABTestCalculatorResult.new(@total_visitors_A,
                               @conversions_A,
                               @total_visitors_B,
                               @conversions_B,
                               0.0, 0.0, 0.0)
  end

  def conversion_stats_for(n_conversions, n_visitors)
    conv_ratio = n_conversions.to_f / n_visitors
    standard_error = Math.sqrt(conv_ratio * (1 - conv_ratio) / n_visitors)
    margin = standard_error * STDERRS_95_CONFIDENCE
    return conv_ratio, standard_error, margin
  end

  def range_95_percent(conversion_rate, error_margin)
    Range.new(conversion_rate - error_margin, conversion_rate + error_margin)
  end

  def covers_endpoint(range_a, range_b)
    range_a.cover?(range_b.begin) || range_a.cover?(range_b.end)
  end

  def ranges_overlap(range_a, range_b)
    covers_endpoint(range_a, range_b) || covers_endpoint(range_b, range_a)
  end

  def compute_significance(result)
    range_A = range_95_percent(result.conversion_ratio_A, result.error_margin_A)
    range_B = range_95_percent(result.conversion_ratio_B, result.error_margin_B)
    result.significant_95_percentile = !ranges_overlap(range_A, range_B)
    result
  end
end
