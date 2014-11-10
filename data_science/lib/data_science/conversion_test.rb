require 'json'

class ConversionTest
  attr_reader :name, :sample

  def initialize(name)
    @name = name
    @sample = Sample.new
  end

  def load(from_file)
    json_string = IO.read(from_file)
    JSON.parse(json_string)
  end
end
