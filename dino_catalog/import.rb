require 'csv'

class Import
  def initialize(catalog)
    @dinosaurs = catalog.items
    @attrs = {}
    dinodex_import
    african_import
  end

  def dinodex_import
    CSV.foreach("dinodex.csv", headers: true, converters: :all) do |row|
      name = row["NAME"]
      @attrs[:period] = row["PERIOD"]
      @attrs[:continent] = row["CONTINENT"]
      @attrs[:diet] = row["DIET"]
      @attrs[:weight] =  row["WEIGHT_IN_LBS"].to_i
      @attrs[:walking] = row["WALKING"]
      @attrs[:description] = row["DESCRIPTION"]
      @dinosaurs << Dinosaur.new(name, @attrs)
      puts "added >>" + name
    end
    puts "file one complete"
  end

  def african_import
    CSV.foreach("african_dinosaur_export.csv",
      headers: true, converters: :all) do |row|
      name = row["Genus"]
      @attrs[:period] = row["Period"]
      @attrs[:continent] = "Africa"
      @attrs[:diet] = convert_carnivore_to_diet(row)
      @attrs[:weight] =  row["Weight"].to_i
      @attrs[:walking] = row["Walking"]
      @attrs[:description] = ""
      @dinosaurs << Dinosaur.new(name, @attrs)
      puts "added >>" + name
    end
    puts "file two complete"
  end

  def convert_carnivore_to_diet(row)
    if row["Carnivore"] == "Yes"
      "Carnivore"
    else
      ""
    end
  end
end
