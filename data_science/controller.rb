require 'data_parser'
require 'cohort'
require 'loader'


class Controller
  def initialize
  end

  def run
    load_file
    parse_json
    calculate_conversion_percentage
    calculate_confidence_level
    report
  end

  def load_file(filename)
    loader = Loader.new(filename)
  end
end
