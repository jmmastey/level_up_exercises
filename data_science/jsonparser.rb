require 'json'

class JSONParser
  def self.read_data(input_file)
    JSON.parse(File.read(input_file))
  end
end
