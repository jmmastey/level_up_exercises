require "json"

class LoadJSON
  attr_accessor :file_path

  def initialize(file_name)
    @file_path = File.expand_path(file_name)
  end

  def parse
    JSON.parse(File.read(file_path))
  end
end
