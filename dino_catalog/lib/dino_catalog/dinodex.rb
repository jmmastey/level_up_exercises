require_relative '../dino_catalog'
require_relative ''

module DinoCatalog
  class Dinodex
    include DinoCatalog::DinoPrinter
    include DinoCatalog::DinoSerializer
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

    def big
      self.class.new(dinosaurs.select(&:big?))
    end

    def small
      self.class.new(dinosaurs.select(&:small?))
    end

    def filter(attribute:, value:)
      dinos = dinosaurs.select do |dinosaur|
        val_of_attribute = dinosaur.send(attribute).to_s
        val_of_attribute.to_s.downcase == value.downcase
      end
      self.class.new(dinos)
    end
  end
end
