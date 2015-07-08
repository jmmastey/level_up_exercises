require 'csv'
require_relative 'dinosaur.rb'
require_relative 'dinosaur_row_reader.rb'
require_relative 'pirate_bay_row_reader.rb'
require_relative 'user_row_reader.rb'
require_relative 'dinosaur_collection_printer.rb'

class DinosaurCollection
  def initialize
    @filter = []
    @dinosaurs = []
    init_readers
  end

  def init_readers
    options = { headers: true }
    Dir["*.csv"].each do |file|
      CSV.foreach(file, options) do |row|
        init_pirate_bay_row(row) if row.header?("Genus")
        init_user_row(row) if row.header?("NAME")
      end
    end
  end

  def init_pirate_bay_row(row)
    @dinosaurs << PirateBayRowReader.new.parse_row(row)
  end

  def init_user_row(row)
    @dinosaurs << UserRowReader.new.parse_row(row)
  end

  def select_by_walk_type!(walk_type = 'Biped')
    @dinosaurs.select! do |dino|
      dino.is_a?(Dinosaur) && dino.walking == walk_type
    end
    self
  end

  def get_by_name!(dino_name)
    raise ArgumentError, 'Missing name' if dino_name.nil?
    @dinosaurs.select! do |dino|
      dino.name == dino_name
    end
    self
  end

  def select_carnivores!
    @dinosaurs.select!(&:carnivore?)
    self
  end

  def get_by_period!(period = 'Jurassic')
    @dinosaurs.select! do |dino|
      dino.period.include? period
    end
    self
  end

  def select_big!
    @dinosaurs.select!(&:big?)
    self
  end

  def select_small!
    @dinosaurs.select!(&:small?)
    self
  end

  def filter
    @dinosaurs.dup
  end

  def print_filter
    printer = DinosaurCollectionPrinter.new @dinosaurs.dup
    printer.prepare_view
  end

  private :init_pirate_bay_row, :init_pirate_bay_row, :init_user_row
end
