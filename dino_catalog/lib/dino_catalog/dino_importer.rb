require_relative '../dino_catalog'
module DinoCatalog
  class DinoImporter
    class << self
      def import_from_csv(file:, formatter: DinoCatalog::DinodexFormatter)
        parse_csv(file: file, formatter: formatter)
      end

      private

      def parse_csv(file:, formatter: DinoCatalog::DinodexFormatter)
        dinosaur_list = []
        CSV.foreach(file, headers: true) do |row|
          dinosaur = DinoCatalog::Dinosaur.new(formatter.convert(row))
          dinosaur_list << dinosaur
        end
        dinosaur_list
      end
    end
  end
end
