require "abanalyzer"

$LOAD_PATH << 'lib'
require "DataLoader"

class ABTestCalculator
  attr_accessor :data

  def initialize(attrs = {})
    @data = DataLoader.load_data(attrs[:json_file])
  end

  def total_sample_size
    0
  end

  def total_conversions
    0
  end

  def conversion_rate
    0.0
  end
end
