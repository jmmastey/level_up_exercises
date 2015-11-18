require_relative '../dino_catalog'

class DinoCatalog::DinoImporter
  attr_reader :dinosaur_list

  def initialize(csv_file)
    @dinosaur_list = []
    import_from_csv(csv_file)
  end

  def import_from_csv(file, format = nil)
    parse_csv(file, format)
  end

  private

  def parse_csv(file, format = nil)
    CSV.foreach(file, headers: true) do |row|
      format_pirate_bay_data(row) if format == "pirate_bay"
      dinosaur = convert_to_dinosaur(row)
      add_to_list(dinosaur)
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
    row_data["NAME"] =          row_data["Genus"]
    row_data["PERIOD"]	=       row_data["Period"]
    row_data["CONTINENT"] =     "Africa"
    row_data["WEIGHT_IN_LBS"] = row_data["Weight"]
    row_data["WALKING"] =       row_data["Walking"]
    if row_data["Carnivore"] == "Yes"
      row_data["DIET"] = "Carnivore"
    else
      row_data["DIET"] = "Herbivore"
    end
  end

  def add_to_list(dinosaur)
    dinosaur_list << dinosaur
  end
end
