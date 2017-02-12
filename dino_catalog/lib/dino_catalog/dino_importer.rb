require_relative '../dino_catalog'
module DinoCatalog
  class DinoImporter
    def self.import_from_csv(file:, formatter: DinoCatalog::DinodexFormatter)
      parse_csv(file: file, formatter: formatter)
    end

    private

    def self.parse_csv(file:, formatter: DinoCatalog::DinodexFormatter)
      dinosaur_list = []
      CSV.foreach(file, headers: true) do |row|
        dinosaur_list << DinoCatalog::Dinosaur.new(formatter.convert(row))
      end
      dinosaur_list
    end
  end
end
