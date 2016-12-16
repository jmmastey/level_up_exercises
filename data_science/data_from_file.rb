require 'JSON'

module DataFromFile
  def self.get(file_path)
    json_file = File.read(file_path)
    JSON.parse(json_file)
  end
end
