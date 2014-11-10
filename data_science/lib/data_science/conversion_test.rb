require 'json'

class ConversionTest
  attr_reader :name, :sample

  def initialize(name)
    @name = name
    @sample = Sample.new
  end
end
