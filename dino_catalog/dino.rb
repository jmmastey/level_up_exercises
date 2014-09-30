require 'csv'
require_relative 'dinosaur'
require_relative 'dinoparser'

class Dino

  def initialize
    @dinosaurs = []
  end


  def merge(file_paths)
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
      AfricanDinoParser.new
    else
      DinoDexParser.new
    end
  end

  def to_s
    @dinosaurs.join("\n")
  end

  def combined(k1,q1,k2,q2)
    @dinosaurs.select do |dinosaur|
      dinosaur.send(k1) == q1 && dinosaur.send(k2) == q2 
    end
  end
  
  def filter(key,query) 
    @dinosaurs.select {|dinosaur| dinosaur.send(key) == query}
  end

  def search_filter(key, query)
    @dinosaurs.select {|dinosaur| dinosaur.send(key) =~ /#{query}/}
  end

end

