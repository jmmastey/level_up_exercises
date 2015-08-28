require_relative 'csv_parser'
require_relative 'printer'

class DinosaurCatalog
  TWO_TONS = 4000
  attr_accessor :dinosaurs

  def initialize(*file_paths)
    @dinosaurs = []
    file_paths.each do |file_path|
      @dinosaurs.concat(CsvParser.read_csv_file(file_path))
    end
  end

  def pass_new_instance_for_filter(dinosaurs)
    new_catalog = DinosaurCatalog.new
    new_catalog.dinosaurs = dinosaurs
    new_catalog
  end

  def all_dinosaurs
    self
  end

  def filter_by_name(name)
    dino = @dinosaurs.detect { |dinosaur| dinosaur.name == name.downcase }
    dinos = dino.nil? ? [] : [dino]
    pass_new_instance_for_filter(dinos)
  end

  def filter_by_walking(walking_type)
    dinos = @dinosaurs.select { |dino| dino.walking == walking_type.downcase }
    pass_new_instance_for_filter(dinos)
  end

  def filter_by_period(period)
    dinos = @dinosaurs.select { |dino| dino.period.include?(period.downcase) }
    pass_new_instance_for_filter(dinos)
  end

  def filter_by_diet(diet)
    if diet.downcase == "carnivore"
      dinos = @dinosaurs.select(&:carnivorous?)
    else
      dinos = @dinosaurs.select { |dino| dino.diet == diet.downcase }
    end
    pass_new_instance_for_filter(dinos)
  end

  def filter_by_weight(weight)
    weight > TWO_TONS ? big_dinos : small_dinos
  end

  def filter_by_continent(continent)
    dinos = @dinosaurs.select { |dino| dino.continent == continent.downcase }
    pass_new_instance_for_filter(dinos)
  end

  def print
    Printer.print_names(@dinosaurs)
    puts
  end

  def print_with_facts
    Printer.print_with_facts(@dinosaurs)
    puts
  end

  private

  def big_dinos
    dinos = @dinosaurs.select do |dino|
      !dino.weight.nil? && dino.weight > TWO_TONS
    end
    pass_new_instance_for_filter(dinos)
  end

  def small_dinos
    dinos = @dinosaurs.select do |dino|
      !dino.weight.nil? && dino.weight <= TWO_TONS
    end
    pass_new_instance_for_filter(dinos)
  end
end
