require "csv"

def load_index
  csv = CSV.read("dinodex.csv", headers: :first_row)
  csv.map do |row|
    dino = Dinosaur.new
    dino.name = row["NAME"]
    dino.period = row["PERIOD"]
    dino.diet = row["DIET"]
    dino.weight = row["WEIGHT_IN_LBS"].to_i
    dino.walking = row["WALKING"]
    dino.description = row["DESCRIPTION"]
    dino.continent = row["CONTINENT"]
    dino
  end
end
                                                                     
def load_african
  csv = CSV.read("african_dinosaur_export.csv", headers: :first_row)
  csv.map do |row|
    dino = Dinosaur.new
    dino.name = row["Genus"]
    dino.period = row["Period"]
    dino.diet = row["Carnivore"] == "yes" ? "Carnivore" : ""
    dino.weight = row["Weight"].to_i
    dino.walking = row["Walking"]
    dino
  end
end
