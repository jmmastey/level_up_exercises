require 'json'

class JsonReader
  attr_accessor :data_hash

  def load_data(path)
    file = File.read(path)
    @data_hash = JSON.parse(file)
  end
end
