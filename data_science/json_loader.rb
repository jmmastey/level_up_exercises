require 'JSON'

class JSONLoader
  attr_accessor :file_name, :data

  def initialize(file_name)
    @file_name = file_name
  end

  def fetch_data
    @data = JSON.parse(File.read(@file_name))
  end
end
