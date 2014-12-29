require_relative 'dino_filter'
require_relative 'dino_csv_tools'
include DinoCSVTools
class DinoDex
  include DinoFilter
  attr_reader :dinosaurs

  def initialize(csvs)
    dino_list = CSVtoDinos.csv_to_dinos(csvs)
    @dinosaurs = dino_list.map { |dino| Dino.new(dino) }
  end

  def find_dino(dino_name)
    @dinosaurs.detect { |dino| dino.name == dino_name }
    
  end

  def filter_dinos(filters)
    filters.map { |filter| process_filter(@dinosaurs, filter) }.inject(:&)
  end

  def to_a
    @dinosaurs.map { |dino| dino.name }
  end

  private

  def process_filter(dinos, filter)
    periods = %w( jurassic albian cretaceous triassic permian oxfordian )
    attributes = %w( fat small biped quadruped carnivore herbivore )
    collections = %w( joe pirate_bay )
    continents = %w( north_america south_america africa europe asia )

    case
      when periods.include?(filter) then period_filter(dinos, filter)
      when attributes.include?(filter) then attribute_filter(dinos, filter)
      when collections.include?(filter) then collection_filter(dinos, filter)
      when continents.include?(filter) then continent_filter(dinos, filter)
    end

  end

  def attribute_filter(dinos, filter)
    dinos.select { |dino| dino.send("#{filter}?") }
  end

  def period_filter(dinos, filter)
    dinos.select { |dino| dino.period.include? filter }
  end

  def continent_filter(dinos, filter)
    dinos.select { |dino| dino.continent.include? filter.tr('_', ' ') }
  end

  def collection_filter(dinos, filter)
    if filter == "pirate_bay" then filter_by_continent(dinos, "africa")
    else dinos.select { |dino| dino.continent != "africa" }
    end
  end

end