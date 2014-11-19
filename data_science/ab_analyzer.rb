require_relative 'ab_test_data'
require_relative 'p_alpha_table'
require_relative 'chi_square_test'
require_relative 'ab_data_parser'

class ABAnalyzer
  extend ChiSquareTest

  extend PAlphaTable

  def initialize(data)
    @datas = {}
    keys = data.keys
    @variant_a, @variant_b = keys[0].to_sym, keys[1].to_sym
    @datas[@variant_a] = ABTestData.new(data[@variant_a])
    @datas[@variant_b] = ABTestData.new(data[@variant_b])
  end

  def conversion_rate(variation)
    @datas[variation].conversion_rate * 100
  end

  def standard_error(variation)
    @datas[variation].standard_error
  end

  def distribution_range(variation)
    range = @datas[variation].distribution_range
    [range[0] * 100, range[1] * 100]
  end

  def chi_square_score
    ChiSquareTest.calculate(@datas[@variant_a], @datas[@variant_b])
  end

  def confidence_level
    (1 - PAlphaTable.significance_level(1, chi_square_score)) * 100
  end

  def winner
    variation_a_rate = @datas[@variant_a].conversion_rate
    variation_b_rate = @datas[@variant_b].conversion_rate
    if variation_a_rate == variation_b_rate
      'No winner'
    else
      variation_a_rate > variation_b_rate ? @variant_a.to_s : @variant_b.to_s
    end
  end
end
