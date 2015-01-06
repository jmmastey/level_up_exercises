require 'json'
require 'abanalyzer'

class ABCalculator
  attr_accessor :a_data, :b_data

  def initialize(a_b_results)
    @a_data = a_b_results[:a_group]
    @b_data = a_b_results[:b_group]
    # tester = ABAnalyzer::ABTest.new(a_b_results)
  end

  def sample_size
    {
      a_total: @a_data[:pass] + @a_data[:fail],
      b_total: @b_data[:pass] + @b_data[:fail],
    }
  end

  def conversion_rate
    {
      a_conversion: @a_data[:pass].to_f / sample_size[:a_total],
      b_conversion: @b_data[:pass].to_f / sample_size[:b_total],
    }
  end
end
