require 'json'
require 'pry'

class ParsedData
  attr_accessor :content

  def initialize(file)
    raise "Please provide an input file" unless file
    json = File.read(file)
    @content = JSON.parse(json)
  end

  def size
    @content.size
  end
end
