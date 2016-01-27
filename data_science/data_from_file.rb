require 'JSON'

module DataFromFile
  module_function

  def get(file_path)
    json_file = File.read(file_path)
    JSON.parse(json_file)
  end
end
