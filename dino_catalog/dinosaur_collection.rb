require 'csv'
require_relative 'dinosaur.rb'
require_relative 'dinosaur_row_reader.rb'
require_relative 'pirate_bay_row_reader.rb'
require_relative 'user_row_reader.rb'
require_relative 'dinosaur_collection_printer.rb'

class DinosaurCollection

  def initialize (collection = nil)
    @filter = []
    @dinosaurs = []
    # collection.nil? ? @dinosaurs = [] : @dinosaurs = collection
    init_readers# if collection.nil?
  end

  def init_readers
    options = { headers: true }
    Dir["*.csv"].each do |file|
      CSV.foreach(file, options) do |row|
        init_pirate_bay_row(row) if row.header?("Genus")
        init_user_row(row) if row.header?("NAME")
      end
    end
    @dino_copy = @dinosaurs.dup
  end

  def init_pirate_bay_row(row)
    @dinosaurs << PirateBayRowReader.new.parse_row(row)
  end

  def init_user_row(row)
    @dinosaurs << UserRowReader.new.parse_row(row)
  end

  def select_by_walk_type(walk_type = 'Biped')
    @dinosaurs = @dinosaurs.select do |dino|
      dino.is_a?(Dinosaur) && dino.walking == walk_type
    end
    self
  end

  def get_by_name(dino_name)
    raise ArgumentError, 'Missing name' if dino_name.nil?
    @dinosaurs = @dinosaurs.select do |dino|
      dino.name == dino_name
    end
    self
  end

  def select_carnivores
    @dinosaurs = @dinosaurs.select { |dino| (dino.carnivore?) }
    self
  end

  def get_by_period(period = 'Jurassic')
    @dinosaurs = @dinosaurs.select do |dino|
      dino.period.include? (period)
    end
    self
  end

  def select_big
    @dinosaurs.select! { |dino| (dino.big?) }
    self
  end

  def select_small
    @dinosaurs.select! { |dino| (dino.small?) }
    self
  end

  def select
    @dinosaurs
  end

  def print_filter
    printer = DinosaurCollectionPrinter.new @dinosaurs.dup
    printer.prepare_view

  end

  private :init_pirate_bay_row, :init_pirate_bay_row, :init_user_row
end
