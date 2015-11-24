require_relative '../dino_catalog'
module DinoCatalog
  class DinoImporter
    class << self
      def import_from_csv(file:, format: :dinodex)
        parse_csv(file: file, format: format)
      end

      private

      def parse_csv(file:, format: :dinodex)
        dinosaur_list = []
        CSV.foreach(file, headers: true) do |row|
          format_pirate_bay_data(row) if format == :pirate_bay
          dinosaur = convert_to_dinosaur(row)
          dinosaur_list << dinosaur
        end
        dinosaur_list
      end

      def convert_to_dinosaur(row_data)
        DinoCatalog::Dinosaur.new(
          name:             row_data["NAME"],
          period:           row_data["PERIOD"],
          continent:        row_data["CONTINENT"],
          diet:             row_data["DIET"],
          weight_in_lbs:    row_data["WEIGHT_IN_LBS"].to_i,
          size:             row_data["SIZE"],
          walking:          row_data["WALKING"],
          description:      row_data["DESCRIPTION"],
        )
      end

      def format_pirate_bay_data(row_data)
        row_data["NAME"] = row_data["Genus"]
        row_data["PERIOD"]	= row_data["Period"]
        row_data["CONTINENT"] =     "Africa"
        row_data["WEIGHT_IN_LBS"] = row_data["Weight"]
        row_data["WALKING"] =       row_data["Walking"]
        row_data["DIET"] = "Carnivore" == "Yes" ? "Carnivore" : "Herbivore"
      end
    end
  end
end
