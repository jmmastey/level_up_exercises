require 'json'
require_relative 'sample'

class Parser
  def self.parse(file)
    if File.exist?(file)
      data = JSON.parse(File.read(file))
      data.map { |row| Sample.new(row) }
    else
      raise 'File not found'
    end
  end
end
