require "json"
require_relative 'dino_filter'

class DinoCatalog
  attr_accessor :dinosaurs, :dino_files

  def initialize(dinosaurs: [], dino_files: nil)
    @dinosaurs = dinosaurs
    @dino_files = dino_files
    load_dino_files
  end

  def load_dino_files
    return if dino_files.nil?
    dino_files.each { |file| dinosaurs.concat(file.read) }
  end

  def search_by_multiple_attrs(attr_requirements)
    attr_requirements.each_with_object(dinosaurs) do |attr_value_pair, dinos|
      attr = attr_value_pair[0]
      desired_value = attr_value_pair[1]
      dinos.replace(search_by_attr(attr, desired_value))
    end
  end

  def search_by_attr(dino_attr, desired_value)
    filter = DinoFilter.new(dino_attr, desired_value)
    filter.search(dinosaurs)
  end

  def export_as_json(path)
    dinos = dinosaurs.each.map(&:to_h)
    path << ".json" unless path.include?(".json")
    File.open(path, mode: "w") do |file|
      file.write(JSON.generate(dinos))
    end
  end
end
