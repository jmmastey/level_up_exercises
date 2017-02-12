module DinoCatalog
  class DinodexFormatter
    def self.convert(row_data)
      {
        name:             row_data["NAME"],
        period:           row_data["PERIOD"],
        continent:        row_data["CONTINENT"],
        diet:             row_data["DIET"],
        weight_in_lbs:    row_data["WEIGHT_IN_LBS"].to_i,
        size:             row_data["SIZE"],
        walking:          row_data["WALKING"],
        description:      row_data["DESCRIPTION"],
      }
    end
  end
end
