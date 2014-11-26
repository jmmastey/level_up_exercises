require "csv"

class DinosaurParser
  MAPPING = { "NAME"          => "Genus",
              "PERIOD"        => "Period",
              "DIET"          => "Carnivore",
              "WEIGHT_IN_LBS" => "Weight",
              "WALKING"       => "Walking",
            }

  def parse
    @result_dinosaurs = []
    parse_csv("dinodex.csv")
    parse_csv("african_dinosaur_export.csv")
    @result_dinosaurs
  end

  private

  def parse_csv(file_name)
    CSV.foreach(file_name, headers: true) do |row|
      dinosaur = {}
      MAPPING.keys.each do |param|
        dinosaur[param] = extract_csv(row, param)
      end
      @result_dinosaurs << dinosaur
    end
  end

  def extract_csv(row, key)
    if key == "DIET"
      row[key] || check_diet(row[MAPPING[key]])
    elsif key == "CONTINENT"
      row[key] || "Africa"
    else
      row[key] || row[MAPPING[key]]
    end
  end

  def check_diet(row_value)
    if row_value == "Yes"
      return "Carnivore"
    else
      return "Herbivore"
    end
  end
end
