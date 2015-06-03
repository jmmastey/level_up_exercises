$LOAD_PATH << '.'
require 'dinosaur_loader'
require 'dinosaur_catalog'

class DinoDex
  INSTRUCTIONS = "instructions.txt"
  GREETING = "DinoDex:"

  def initialize(catalog_dir)
    dinos = DinosaurLoader.new(catalog_dir).dinosaurs
    @dinosaur_catalog = DinosaurCatalog.new(dinos)
  end

  def run_user_interface
    loop do
      print GREETING
      query = gets.chomp.split('.')
      abort if query == ["exit"]
      @dinosaur_catalog = @dinosaur_catalog.process_query(query)
      @dinosaur_catalog.facts
    end
  end

  def print_instructions
    File.readlines(INSTRUCTIONS).each do |line|
      puts line
    end
  end
end

dino_dex = DinoDex.new('catalogs/')
dino_dex.print_instructions
dino_dex.run_user_interface
