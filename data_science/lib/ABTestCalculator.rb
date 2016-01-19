require "abanalyzer"

$LOAD_PATH << 'lib'
require "DataLoader"

class ABTestCalculator
  attr_accessor :data

  def initialize(attrs = {})
    @data = DataLoader.load_data(attrs[:json_file])

    values = { A: @data[:A][:results], B: @data[:B][:results] }
    @analyzer = ABAnalyzer::ABTest.new values
  end

  def confidence_level
    @analyzer.chisquare_p
  end
end
