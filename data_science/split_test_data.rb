require 'json'

class SplitTestData
  attr_reader :data

  def initialize(json)
    @data = JSON.parse(json)
  end
end