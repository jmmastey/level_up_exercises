require 'csv'
require_relative 'dinosaur_file_reader.rb'
require_relative 'pirate_bay_file_reader.rb'
require_relative 'user_file_reader.rb'
require_relative 'dinosaur.rb'
require_relative 'dinosaur_collection_printer.rb'

class DinosaurCollection
  @dinosaurs = []
  @filter = []
  def initialize
    @dinosaurs = [] if @dinosaurs.nil?
    init_readers
  end

  def init_readers
    Dir["*.csv"].each do |file|
      line = CSV.read file
      case line[0][0]
        when "Genus"
          init_pirate_bay_reader(file)
        when "NAME"
          init_user_file_reader(file)
        else
          raise "Unknown csv file found: :{file}"
      end
    end
  end

  def init_user_file_reader(file)
    @dinosaurs += UserFileReader.new(file).dinosaurs
  end

  def init_pirate_bay_reader(file)
    pirate_bay_reader = PirateBayFileReader.new(file)
    @dinosaurs += pirate_bay_reader.dinosaurs
  end

  def select_by_walk_type(walk_type = 'Biped')
    @dinosaurs = @dinosaurs.select do |dino|
      (dino.is_a?(Dinosaur) && dino.walking == walk_type)
    end
    self
  end

  def get_by_name(dino_name)
    raise ArgumentError, 'Missing name' if dino_name.nil?
    @dinosaurs = @dinosaurs.select do |dino|
      (dino.name == dino_name)
    end
    self
  end

  def select_carnivores
    @dinosaurs = @dinosaurs.select do |dino|
      (dino.carnivore?)
    end
    self
  end

  def get_by_period(period = 'Jurassic')
    # p @dinosaurs[0].is_a?(Dinosaur)
    @dinosaurs = @dinosaurs.select do |dino|
      #  p dino.is_a?(Dinosaur)
      (dino.period.include? period)
    end
    self
  end

  def select_big
    @dinosaurs = @dinosaurs.select do |dino|
      (!dino.weight_in_tons.nil? && dino.weight_in_tons > 2.0)
    end
    self
  end

  def select_small
    @dinosaurs = @dinosaurs.select do |dino|
      #  p dino.is_a?(Dinosaur)
      (!dino.weight_in_tons.nil? && dino.weight_in_tons <= 2.0)
    end
    self
  end

  def filter
    @dinosaurs
  end

  def print_filter
    printer = DinosaurCollectionPrinter.new
    output = printer.print_header
    @dinosaurs.each do |dino|
      output = printer.print_row(dino, output)
      output = printer.print_delimiter(output)
    end
    output
  end
end
