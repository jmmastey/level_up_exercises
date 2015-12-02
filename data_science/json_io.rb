require "json"

class JsonIO
  attr_accessor :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def read
    file = open(@file_path)
    JSON.load(file)
  end
end
