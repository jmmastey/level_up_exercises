require 'json'

class FileReader
  attr_accessor :data

  def initialize(file_path)
    raise IOError, "Invalid input file path" if file_path.to_s.strip.empty?
    raise IOError, "File does not exist" unless File.exist?(file_path)

    @data = JSON.parse(File.read(file_path))
  end
end
