require "json"

class LoadJSON
  attr_accessor :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def parse
    JSON.parse(File.read(path))
  end

  def path
    File.expand_path(file_name)
  end

  def exist?
    File.exist?(path)
  end
end
