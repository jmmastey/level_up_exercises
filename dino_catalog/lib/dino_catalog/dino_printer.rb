require_relative '../dino_catalog'

module DinoCatalog
  module DinoPrinter
    def print
      if self.is_a?(DinoCatalog::Dinosaur)
        puts self
      elsif self.is_a?(DinoCatalog::Dinodex)
        dinosaurs.each { |dinosaur| puts dinosaur.to_s + "\n\n" }
      end
    end
  end
end
