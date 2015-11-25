require_relative '../dino_catalog'

module DinoCatalog
  class Dinodex
    attr_reader :dinosaurs

    def initialize(dinosaurs)
      @dinosaurs = dinosaurs
    end

    def carnivores
      self.class.new(dinosaurs.select(&:carnivore?))
    end

    def bipeds
      self.class.new(dinosaurs.select(&:biped?))
    end

    def filter(attribute:, value:)
      dinos = dinosaurs.select do |dinosaur|
        # raise "Invalid attribute type. Use a String." unless attribute.is_a?(String)
        val_of_attribute = dinosaur.send(attribute).to_s
        val_of_attribute.downcase == value.downcase unless val_of_attribute.nil?
      end
      self.class.new(dinos)
    end
  end
end
