require_relative 'catalog'
require 'table_print'

class Import
  def initialize
    attrs = {}
    # NAME,PERIOD,CONTINENT,DIET,WEIGHT_IN_LBS,WALKING,DESCRIPTION
    CSV.foreach("dinodex.csv", headers: true, converters: :all) do |row|
      name = row["NAME"]
      attrs[:period] = row["PERIOD"]
      attrs[:continent] = row["CONTINENT"]
      attrs[:diet] = row["DIET"]
      attrs[:weight] =  row["WEIGHT_IN_LBS"]
      attrs[:walking] = row["WALKING"]
      attrs[:description] = row["DESCRIPTION"]
      puts "added >>" + name
      Catalog.dinosaurs << Dinosaur.new(name, attrs)
    end

    # Genus,Period,Carnivore,Weight,Walking
    CSV.foreach("african_dinosaur_export.csv",
      headers: true, converters: :all) do |row|
      name = row["Genus"]
      attrs[:period] = row["Period"]
      attrs[:continent] = "Africa"
      attrs[:diet] = convert_carnivore_to_diet(row)
      attrs[:weight] =  row["Weight"]
      attrs[:walking] = row["Walking"]
      attrs[:description] = "Very little is known"
      puts "added >>" + name
      Catalog.dinosaurs << Dinosaur.new(name, attrs)
    end
  end

  def convert_carnivore_to_diet(row)
    if row["Carnivore"] == "Yes"
      "Carnivore"
    else
      "Unknown"
    end
  end
end
