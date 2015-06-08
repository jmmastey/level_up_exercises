require 'json'

class ImportData
  attr_reader :data

  def initialize(filename)
    file = File.read(filename)
    @data = JSON.parse(file)
  end
end
