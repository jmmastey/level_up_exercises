require "csv"

class DinosaurParser
  CSV_HEADER_MAPPING = { "NAME"          => "Genus",
                         "PERIOD"        => "Period",
                         "DIET"          => "Carnivore",
                         "WEIGHT_IN_LBS" => "Weight",
                         "WALKING"       => "Walking",
            }

  def parse
    result_dinosaurs = []
    result_dinosaurs << parse_csv("dinodex.csv")
    result_dinosaurs << parse_csv("african_dinosaur_export.csv")
    result_dinosaurs.flatten!
  end

  private

  def parse_csv(file_name)
    result_dinosaurs = []
    raise("File not found") unless File.exist?(file_name)

    CSV.foreach(file_name, headers: true) do |row|
      dinosaur = build_dinosaur(row)
      result_dinosaurs << dinosaur
    end
    result_dinosaurs
  end

  def build_dinosaur(row)
    dinosaur = {}
    CSV_HEADER_MAPPING.keys.each do |param|
      dinosaur[param] = extract_csv(row, param)
    end
    dinosaur
  end

  def extract_csv(row, key)
    case key
      when "DIET"
        row[key] || check_diet(row[CSV_HEADER_MAPPING[key]])
      when "CONTINENT"
        row[key] || "Africa"
      else
        row[key] || row[CSV_HEADER_MAPPING[key]]
    end
  end

  def check_diet(row_value)
    return "Carnivore" if row_value == "Yes"
    "Herbivore"
  end
end
