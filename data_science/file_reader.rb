require 'json'

class FileReader
  attr_accessor :data

  def initialize(file_path)
    @data = {}

    if file_path.to_s.strip.empty?
      raise IOError, "Invalid input file path"
    end

    unless File.exist?(file_path)
      raise IOError, "File does not exist"
    end

    @data = JSON.parse(File.read(file_path))
  end
end
