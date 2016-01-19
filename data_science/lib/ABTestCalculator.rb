require "abanalyzer"

$LOAD_PATH << 'lib'
require "DataLoader"

class ABTestCalculator
  attr_accessor :data

  def initialize(attrs = {})
    @data = DataLoader.load_data(attrs[:json_file])
  end
end
