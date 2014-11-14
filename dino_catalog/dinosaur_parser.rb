require "csv"

class DinosaurParser
  def parse
    @result_dinosaurs = []
    CSV.foreach("dinodex.csv", :headers => true) do |row|
      @result_dinosaurs << row.to_hash
    end

    CSV.foreach("african_dinosaur_export.csv", :headers => true) do |row|
      dinosaur = {}
      dinosaur["NAME"]          = row["Genus"]
      dinosaur["PERIOD"]        = row["Period"]
      dinosaur["CONTINENT"]     = "Africa"
      dinosaur["DIET"]          = "Carnivore" if row["Carnivore"] == "Yes"
      dinosaur["WEIGHT_IN_LBS"] = row["Weight"]
      dinosaur["WALKING"]       = row["Walking"]
      dinosaur["DESCRIPTION"]   = ""
      @result_dinosaurs << dinosaur
    end
    @result_dinosaurs
  end
end