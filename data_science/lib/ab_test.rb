require_relative "ab_test/ab_test_group.rb"

class ABTest
  attr_reader :group_A, :group_B

  CHI_SQUARE_95_CONFIDENCE_CRITERION = 3.81

  def initialize
    @group_A = ABTestGroup.new
    @group_B = ABTestGroup.new
  end

  def total_nonconverts
    @group_A.nonconverts + @group_B.nonconverts
  end

  def total_converts
    @group_A.converts + @group_B.converts
  end

  def total_visitors
    total_converts + total_nonconverts
  end

  def chi_square_value
    exp_noncvt_A, exp_cvt_A, exp_noncvt_B, exp_cvt_B = calculate_expectations

    ( ((@group_A.nonconverts - exp_noncvt_A) ** 2) / exp_noncvt_A  +
      ((@group_A.converts - exp_cvt_A) ** 2) / exp_cvt_A           +
      ((@group_B.nonconverts - exp_noncvt_B) ** 2) / exp_noncvt_B  +
      ((@group_B.converts - exp_cvt_B) ** 2) / exp_cvt_B )
  end

  def significant_95_confidence
    chi_square_value > CHI_SQUARE_95_CONFIDENCE_CRITERION
  end

  private

  def calculate_expectations
    n = total_visitors
    n_A, n_B = @group_A.visitors, @group_B.visitors
    n_converts, n_nonconverts = total_converts, total_nonconverts
    return expected_value(n_A, n_nonconverts, n),
           expected_value(n_A, n_converts, n),
           expected_value(n_B, n_nonconverts, n),
           expected_value(n_B, n_converts, n)
  end

  def expected_value(category_total, group_total, total_samples)
    category_total.to_f * group_total / total_visitors
  end
end
