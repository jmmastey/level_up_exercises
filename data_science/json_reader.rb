require 'json'

class JSONReader
  def self.read_file(file_path)
    file = File.read(file_path)
    JSON.parse(file)
  end
end
