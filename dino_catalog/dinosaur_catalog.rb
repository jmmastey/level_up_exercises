require_relative 'csv_parser'
require_relative 'printer'

class DinosaurCatalog
  TWO_TONS = 4000
  attr_accessor :dinosaurs

  def initialize(*file_paths)
    @dinosaurs = []
    file_paths.each do |file_path|
      @dinosaurs.concat(Parser.read_csv_file(file_path))
    end
  end

  def pass_new_instance_for_filter(dinosaurs)
    new_catalog = DinosaurCatalog.new
    new_catalog.dinosaurs = dinosaurs
    new_catalog
  end

  def all_dinosaurs
    pass_new_instance_for_filter(@dinosaurs)
  end

  def filter_by_name(name)
    dino = @dinosaurs.find { |dinosaur| dinosaur.name == name }
    dino_array = dino.nil? ? [] : [dino]
    pass_new_instance_for_filter(dino_array)
  end

  def filter_by_walking(walking_type)
    dinos = @dinosaurs.select { |dino| dino.walking == walking_type }
    pass_new_instance_for_filter(dinos)
  end

  def filter_by_period(period)
    dinos = @dinosaurs.select { |dino| dino.period.include?(period) }
    pass_new_instance_for_filter(dinos)
  end

  def filter_by_diet(diet)
    if diet == "Carnivore"
      dinos = @dinosaurs.select(&:carnivorous?)
    else
      dinos = @dinosaurs.select { |dino| dino.diet == diet }
    end
    pass_new_instance_for_filter(dinos)
  end

  def big_dinos
    dinos = []
    @dinosaurs.each do |dino|
      dinos << dino if !dino.weight.nil? && dino.weight.to_i > TWO_TONS
    end
    pass_new_instance_for_filter(dinos)
  end

  def small_dinos
    dinos = []
    @dinosaurs.each do |dino|
      dinos << dino if !dino.weight.nil? && dino.weight.to_i <= TWO_TONS
    end
    pass_new_instance_for_filter(dinos)
  end

  def filter_by_weight(weight)
    if weight > TWO_TONS
      big_dinos
    else
      small_dinos
    end
  end

  def filter_by_continent(continent)
    dinos = @dinosaurs.select { |dino| dino.continent == continent }
    pass_new_instance_for_filter(dinos)
  end

  def print
    Printer.print_just_names(@dinosaurs)
    puts
  end

  def print_with_facts
    Printer.print_with_facts(@dinosaurs)
    puts
  end
end

# For dinodex file
catalog = DinosaurCatalog.new("dino_catalog/dinodex.csv")
puts "Carnivore, Weight 4001"
catalog.filter_by_diet("Carnivore").filter_by_weight(4001).print
puts "Name: Albertosaurus"
catalog.filter_by_name("Albertosaurus").print
puts "Walking: Biped"
catalog.filter_by_walking("Biped").print
puts "Period: Cretaceous"
catalog.filter_by_period("Cretaceous").print
puts "Continent: North America"
catalog.filter_by_continent("North America").print
puts "Diet: Insectivore"
catalog.filter_by_diet("Insectivore").print
puts "No matches"
catalog.filter_by_period("Nothing").print
puts "All dinosuars"
catalog.all_dinosaurs.print
puts "All dinosaurs with facts"
catalog.all_dinosaurs.print_with_facts
