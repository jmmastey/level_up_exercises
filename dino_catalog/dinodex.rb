require_relative "dinoparser"
require_relative "dino"
require "csv"

class DinoDex
  PARSER_MAP = [FavoriteDinoParser.new, AfricanDinoParser.new]

  def initialize(*files_paths)
    @dinos ||= []
    add_data(*files_paths)
  end

  def add_data(*file_paths)
    file_paths.each do |file_path|
      parser = nil
      CSV.foreach(file_path, :headers => true) do |row|
        item = row.to_hash
        parser ||= PARSER_MAP.find { |pmap| pmap.can_parse?(item) }
        @dinos << parser.parse(item)
      end
    end
  end

  def first
    @dinos.first
  end

  def each(&block)
    @dinos.each &block
  end
end


dinodex = DinoDex.new("dinodex.csv", "african_dinosaur_export.csv")

dinodex.each do |dino|
  puts dino
end
