require 'json'

class DataLoader
  attr_accessor :data_source

  def initialize(data_source)
    @data_source = data_source
  end

  def json?
    data_source.end_with?('.json')
  end

  def load_data
    JSON.parse(File.read(data_source)) if json?
  end
end
