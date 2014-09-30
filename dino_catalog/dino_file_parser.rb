require "csv"
require_relative "dinosaur"

class DinoFileParser

  def initialize(parsers_for_type)   
    @parsers_for_type = parsers_for_type
  end

  def load(files)
    files.map {|file| parse_file(file)}.flatten
  end

  private

  def parse_file(file_path)
    parser = get_parser(file_path)
    result = Array.new   
    CSV.foreach(file_path, headers: true) do |entry| 
      result << Dinosaur.new(parser.call(entry)) 
    end
    result
  end

  def get_parser(file_path)
    header = CSV.read(file_path)[0]
    @parsers_for_type[header]
  end

end
