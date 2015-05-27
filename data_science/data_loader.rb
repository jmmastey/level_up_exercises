require 'json'
class DataLoader
  attr_accessor :value
  def initialize(filename)
    raise "File name can not be black." unless filename

    json_string = File.read(filename)
    @value = JSON.parse(json_string)
  end

  def total_size
    @value.size
  end
end
