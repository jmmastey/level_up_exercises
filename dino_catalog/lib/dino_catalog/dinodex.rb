require_relative '../dino_catalog'

class DinoCatalog::Dinodex
  attr_reader :dinosaurs

  def initialize(dinosaurs)
    @dinosaurs = dinosaurs
  end

  def carnivores
    dinosaurs.select do |dinosaur|
      dinosaur.diet.downcase == "carnivore" ||
        dinosaur.diet.downcase == "piscivore" ||
        dinosaur.diet.downcase == "insectivore"
    end
  end

  def bipeds
    filter(attribute: "walking", value: "biped")
  end

  def filter(attribute:, value:)
    dinos = dinosaurs.select do |dinosaur|
      val_of_attribute = dinosaur.send(attribute)
      val_of_attribute.downcase == value.downcase unless val_of_attribute.nil?
    end
    self.class.new(dinos)
  end

  def print_collection(dino_collection = dinosaurs)
    dino_collection.each do |dinosaur|
      puts dinosaur.print_facts
    end
  end
end
