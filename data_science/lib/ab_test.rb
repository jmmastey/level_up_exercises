require_relative "ab_test/ab_test_group.rb"

class ABTest
  attr_reader :group_a, :group_b

  CHI_SQUARE_95_CONFIDENCE_CRITERION = 3.81

  def initialize
    @group_a = ABTestGroup.new
    @group_b = ABTestGroup.new
  end

  def total_nonconverts
    @group_a.nonconverts + @group_b.nonconverts
  end

  def total_converts
    @group_a.converts + @group_b.converts
  end

  def total_visitors
    total_converts + total_nonconverts
  end

  def chi_square_value
    exp_noncvt_a, exp_cvt_a, exp_noncvt_b, exp_cvt_b = calculate_expectations

    (((@group_a.nonconverts - exp_noncvt_a)**2) / exp_noncvt_a  +
     ((@group_a.converts - exp_cvt_a)**2) / exp_cvt_a           +
     ((@group_b.nonconverts - exp_noncvt_b)**2) / exp_noncvt_b  +
     ((@group_b.converts - exp_cvt_b)**2) / exp_cvt_b)
  end

  def significant_95_confidence
    chi_square_value > CHI_SQUARE_95_CONFIDENCE_CRITERION
  end

  def to_text
    significance = significant_95_confidence ? "SIGNIFICANT" : "Insignificant"

    text = group_a.to_text('A')
    text << group_b.to_text('B')
    text << (format <<EOH, chi_square_value, significance)
---- CONCLUSION (95%% confidence criterion) ----
Chi-Square value:         %0.4f
Statistical significance: %s
EOH
  end

  private

  def calculate_expectations
    n_a, n_b = @group_a.visitors, @group_b.visitors
    n_converts, n_nonconverts = total_converts, total_nonconverts
    [
      expected_value(n_a, n_nonconverts),
      expected_value(n_a, n_converts),
      expected_value(n_b, n_nonconverts),
      expected_value(n_b, n_converts),
    ]
  end

  def expected_value(category_total, group_total)
    category_total.to_f * group_total / total_visitors
  end
end
