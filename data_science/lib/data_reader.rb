require 'json'
require_relative 'data_point'

class DataReader
  attr_reader :file_name, :data

  def initialize(file_name)
    @file_name = file_name
    @data = []
    data_hashes = read_json
    data_hashes.each { |hash| @data << DataPoint.new(hash) }
  end

  def read_json
    data_s = File.read(file_name)
    return [] if data_s.empty?
    JSON.parse(data_s, symbolize_names: true)
  rescue JSON::ParserError
    raise BadDataFile, "Unable to parse #{file_name}"
  end
end

class BadDataFile < StandardError
end
