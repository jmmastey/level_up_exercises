require 'json'

module JsonParser
  private

  def read(file)
    raise("File #{file} not found") unless File.exist?(file)
    json = File.read(file)
    JSON.parse(json)
  end
end

=begin
require "json"

class JSONParser
  attr_accessor :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def getdata
    JSON.parse(File.read(file_name))
  end
end
=end