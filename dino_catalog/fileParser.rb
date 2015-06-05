require_relative './dinodex.rb'

class FileParser

  def self.parse_csv_file(filename)
    col_names = [ :name, :period, :continent, :diet, :weight, :walking, :description]
    File.readlines(filename).drop(1).each_with_object([]) do |line, dinos|
      dino_hash = make_hash(line, col_names)
      dinos << Dinosaur.new(dino_hash)
    end
  end

  def self.parse_tpb_file(filename)
    col_names = [ :name, :period, :carnivore, :weight, :walking]
    File.readlines(filename).drop(1).each_with_object([]) do |line, dinos|
      dino_hash = make_hash(line, col_names)
      dinos << Dinosaur.new(canonical_hash(dino_hash)) 
    end
  end

  def self.make_hash(line, col_names)
    Hash[col_names.zip(line.split(",").map { |x| x==""? nil: x})]
  end

  def self.canonical_hash(tpb_hash)
    if tpb_hash[:carnivore] == "Yes"
      tpb_hash[:diet] = "Carnivore"
      tpb_hash[:carnivore] = nil
    end
    tpb_hash[:continent] = "Africa"
  end
end
