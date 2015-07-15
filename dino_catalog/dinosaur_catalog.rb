require_relative 'csv_parser'
require_relative 'dinosaur_utils'

class DinosaurCatalog
  def initialize(*file_paths)
    @dinosaurs = []
    file_paths.each do |file_path|
      @dinosaurs.concat Parser.read_csv_file(file_path)
    end
  end

  def print_individual_dinosaur_facts(dinosaur_name)
    dinosaur = get_dinosaur_by_name(dinosaur_name)
    if dinosaur
      fact_string = print_fact_string(dinosaur)
    else
      fact_string = "That dinosaur couldn't be found in our database. Sorry!\n"
    end

    puts fact_string
  end

  def print_dinosaur_facts_by_criteria(criteria = {})
    if !criteria.empty?
      dinos = DinosaurUtils.list_of_dinosaurs_by_criteria(criteria, @dinosaurs)
      check_returned_dinos_and_print(dinos)
    else
      @dinosaurs.each { |dino| print_individual_dinosaur_facts(dino.name) }
    end
  end

  def check_returned_dinos_and_print(dinosaurs)
    if !dinosaurs.nil?
      dinosaurs.each { |dino| print_individual_dinosaur_facts(dino) }
    else
      puts "That dinosaur couldn't be found in our database. Sorry!\n"
    end
  end

  def print_fact_string(dinosaur)
    puts "The #{dinosaur.name} was from the #{dinosaur.period} period."
    get_continent_string(dinosaur.continent)
    get_weight_string(dinosaur.weight)
    get_walking_string(dinosaur.walking)
    get_diet_string(dinosaur)
    get_description_string(dinosaur.description)
  end

  def get_continent_string(continent)
    puts "It lived in #{continent}." if continent
  end

  def get_walking_string(walking)
    puts "It was a #{walking.downcase}." if walking
  end

  def get_weight_string(weight)
    puts "It weighed #{weight} pounds!" if weight
  end

  def get_description_string(description)
    puts "Fun fact: #{description}\n" if description
  end

  def get_diet_string(dinosaur)
    if dinosaur.diet
      puts "This dinosaur was a #{dinosaur.diet.downcase}."
    elsif dinosaur.carnivorous
      puts "This dinosaur was a carnivore."
    else
      puts "This dinosaur was not a carnivore."
    end
  end

  def get_dinosaur_by_name(name)
    dinosaur = nil
    @dinosaurs.each do |dino|
      dinosaur = dino if dino.name == name
    end
    dinosaur
  end
end

# For dinodex file
catalog = DinosaurCatalog.new("dino_catalog/dinodex.csv")
catalog.print_dinosaur_facts_by_criteria({weight: 2000, diet: "Carnivore"})
