require "json"

class JSONLoader
  attr_accessor :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def fetch_data
    JSON.parse(File.read(@file_name))
  end
end
