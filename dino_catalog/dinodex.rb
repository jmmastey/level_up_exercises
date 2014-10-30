require 'csv'
require 'json'
require_relative 'dinosaur'
require_relative 'dinodex_mapper'
require_relative 'african_dino_mapper'

class DinoDex
  def initialize(dinosaurs = [])
    @dinosaurs = dinosaurs
  end

  def merge_parser(file_paths)
    file_paths.each do |file|
      CSV.foreach(file, headers: true) do |entry|
        parser = correct_parser(entry)
        @dinosaurs << parser.map_dinos(entry)
      end
    end
    @dinosaurs
  end

  def correct_parser(entry)
    if entry.include? 'Genus'
      AfricanDinoMapper.new
    else
      DinoDexMapper.new
    end
  end

  def filter(key, value)
    search { |dinosaur| dinosaur.send(key) =~ /#{value}/ }
  end

  def combined(criteria)
    @dinosaurs.select do |dinosaur|
      criteria.all? do |key, value|
        dinosaur.send(key) == value
      end
    end
  end
  def search(&query)
    DinoDex.new(@dinosaurs.select(&query))
  end

  def to_s
    @dinosaurs.join("\n")
  end

  def to_json
    @dinosaurs.to_json
  end
end
