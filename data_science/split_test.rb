require_relative 'split_test_data'

class SplitTest
  attr_reader :data

  def initialize(split_test_data)
    @data = split_test_data
  end
end