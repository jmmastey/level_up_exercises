require 'json'
require 'pp'

require 'data_science/base'

module DataScience
  module_function

  @ds = Base.new

  def print_statistics(filename)
    ab_test_results = @ds.parse_test_results(filename)
    PP.pp(ab_test_results)
  end
end
