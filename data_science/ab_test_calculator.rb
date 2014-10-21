class ABTestCalculator

  attr_reader :group_A
  attr_reader :group_B

  def initialize
    @group_A = ABTest.new
    @group_B = ABTest.new
  end

  def compute
    r = new_initialized_result
    compute_chi_square_95_percent_confidence(r)
    r
  end

  private

  def new_initialized_result

    r = ABTest.new
    r.visitors_A, r.converts_A = @visitors_A, @converts_A
    r.conversion_ratio_A, r.standard_error_A, r.error_margin_A =
      descriptive_stats_for(@converts_A, @visitors_A)

    r.visitors_B, r.converts_B = @visitors_B, @converts_B
    r.conversion_ratio_B, r.standard_error_B, r.error_margin_B =
      descriptive_stats_for(@converts_B, @visitors_B)

    r
  end

  def descriptive_stats_for(n_converts, n_visitors)
    conv_ratio = n_converts.to_f / n_visitors
    standard_error = Math.sqrt(conv_ratio * (1 - conv_ratio) / n_visitors)
    margin = standard_error * STDERRS_95_CONFIDENCE
    return conv_ratio, standard_error, margin
  end

  def chi_square_by_test_matrix(total_A, converts_A, total_B, converts_B)
    nonconverts_A = total_A - converts_A
    nonconverts_B = total_B - converts_B
    total_samples = total_A + total_B
    total_converts = converts_A + converts_B
    total_nonconverts = nonconverts_A + nonconverts_B

    expected_nonconverts_A = total_nonconverts * total_A / total_samples
    expected_converts_A = total_converts * total_A / total_samples
    expected_nonconverts_B = total_nonconverts * total_B / total_samples
    expected_converts_B = total_converts * total_B / total_samples
 
    ((nonconverts_A - expected_nonconverts_A) ** 2 / expected_nonconverts_A)   +
      ((converts_A - expected_converts_A) ** 2 / expected_converts_A)          +
      ((nonconverts_B - expected_nonconverts_B) ** 2 / expected_nonconverts_B) +
      ((converts_B - expected_converts_B) ** 2 / expected_converts_B)
  end

  def compute_chi_square_95_percent_confidence(abtest)
    abtest.chi_square = 
      chi_square_by_test_matrix(abtest.visitors_A, abtest.converts_A,
                                abtest.visitors_B, abtest.converts_B)

    abtest.significant_95_percentile = abtest.chi_square > 3.81
  end
end
