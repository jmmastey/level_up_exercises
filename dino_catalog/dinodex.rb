require_relative "dinoparser"
require_relative "dino"
require "csv"
require "json"

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

  def find(criteria = {})
    @dinos.find_all do |dino|
      criteria.all? do |field, value|
        if value.is_a? Proc
          value.call(dino.send(field))
        else
          /#{value}/.match(dino.send(field))
        end
      end
    end
  end

  def to_json
    @dinos.map { |dino| dino.to_hash}.to_json
  end
end
