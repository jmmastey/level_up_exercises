require "json"
require_relative "data_entry.rb"

class JSONStatParser
  def initialize
    initialize_parser_options
  end

  def read(file_path)
    data = read_file(file_path)
    parse(data)
  end

  private

  def initialize_parser_options
    @parser_options = {
      object_class: Hash,
      array_class: Array,
      symbolize_names: true
    }
  end

  def read_file(file_path)
    File.read(file_path)
  end

  def parse(source)
    data = JSON.parse(source, @parser_options)
    data.map { |entry| DataEntry.new(entry) }
  end
end
