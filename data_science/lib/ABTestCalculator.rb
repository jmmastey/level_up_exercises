require "abanalyzer"

$LOAD_PATH << 'lib'
require "DataLoader"

class ABTestCalculator
  attr_accessor :data

  def initialize(attrs = {})
    @data = DataLoader.load_data(attrs[:json_file])
  end

  def confidence_level
    values = { A: @data[:A][:results], B: @data[:B][:results] }
    analyzer = ABAnalyzer::ABTest.new values
    analyzer.chisquare_p
  end

  def cohort_conversion_rate
    {
      A: ABAnalyzer.confidence_interval(
        @data[:A][:results][:conversion],
        @data[:A][:total],
        0.95,
      ),
      B: ABAnalyzer.confidence_interval(
        @data[:B][:results][:conversion],
        @data[:B][:total],
        0.95,
      ),
    }
  end
end
