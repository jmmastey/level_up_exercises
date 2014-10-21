class ABTestCalculator

  attr_reader :group_A
  attr_reader :group_B

  def initialize
    @group_A = ABTestGroup.new
    @group_B = ABTestGroup.new
  end

  def compute
    r = new_initialized_result
    compute_chi_square_95_percent_confidence(r)
    r
  end

  private

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
