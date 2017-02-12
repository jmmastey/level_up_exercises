require_relative 'dinosaur.rb'
require_relative 'csvparser.rb'

class Dinodex
  attr_reader :master_dinosaur_list

  def initialize(master_dinosaur_list = CSVParser.new.generate_dinosaur_list)
    @master_dinosaur_list = master_dinosaur_list
  end

  def biped_search
    Dinodex.new(@master_dinosaur_list.select(&:biped?))
  end

  def carnivore_search
    Dinodex.new(@master_dinosaur_list.select(&:carnivore?))
  end

  def period_search(period)
    Dinodex.new(@master_dinosaur_list.select do |dino|
      dino.in_period?(period)
    end)
  end

  def big_search
    Dinodex.new(@master_dinosaur_list.select(&:big?))
  end

  def small_search
    Dinodex.new(@master_dinosaur_list.select(&:small?))
  end

  def to_s
    array_of_strings = @master_dinosaur_list.map do |dinosaur|
      dinosaur.to_s
    end
    array_of_strings.join("\n")
  end

  def export_to_json(filename, dinosaur_data)
    File.open(filename, "w") do |f|
      f.write(JSON.pretty_generate dinosaur_data.master_dinosaur_list.map(&:to_hash))
    end
  end
end

# dinodex = Dinodex.new
# dinodex.african_dino_import
# dinodex.dino_import
# puts dinodex.biped_search
# .period_search("Cretaceous").small_search
