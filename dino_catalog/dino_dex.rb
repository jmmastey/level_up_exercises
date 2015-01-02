require_relative 'dino_csv_tools'
include DinoCSVTools
class DinoDex
  attr_reader :dinosaurs

  FILTER_MAPPING = {
    period_filter: %w( jurassic albian cretaceous triassic permian oxfordian ),
    attribute_filter: %w( fat small biped quadruped carnivore herbivore ),
    collection_filter: %w( joe pirate_bay ),
    continent_filter: %w( north_america south_america africa europe asia ),
  }

  def initialize(csvs)
    dino_list = CSVtoDinos.csv_to_dinos(csvs)
    @dinosaurs = dino_list.map { |dino| Dino.new(dino) }
  end

  def find_dino(dino_name)
    @dinosaurs.detect { |dino| dino.name == dino_name }
  end

  def filter_dinos(filters)
    filters.map { |f| process_filter(@dinosaurs, f) }.compact.inject(:&)
  end

  def to_a
    @dinosaurs.map(&:name)
  end

  private

  def process_filter(dinos, filter)
    FILTER_MAPPING.detect do |k, v|
      return send(k, dinos, filter) if v.include?(filter)
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
    if filter == "pirate_bay" then continent_filter(dinos, "africa")
    else dinos.select { |dino| dino.continent != "africa" }
    end
  end
end
