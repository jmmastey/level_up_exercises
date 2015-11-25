module DinoCatalog 
	class PirateBayFormatter
  	def self.convert(row_data)
      {
        name:             row_data["Genus"],
        period:           row_data["Period"],
        continent:        "Africa",
        weight_in_lbs:    row_data["Weight"],
        walking:          row_data["Walking"],
        diet:             "Carnivore" == "Yes" ? "Carnivore" : "Herbivore"
      }
    end
  end
end