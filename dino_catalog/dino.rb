# User stories:
  # As a user, I want to take in 2 types of csv files and combine the data into one data structure
  # As a user, I want to be able to query my data, with multiple parameters:
    # Grab all the dinosaurs that were bipeds.
    # Grab all the dinosaurs that were carnivores (fish and insects count).
    # Grab dinosaurs for specific periods (no need to differentiate between Early and Late Cretaceous, btw).
    # Grab only big (> 2 tons) or small dinosaurs.
    # Just to be sure, I'd love to be able to combine criteria at will, even better if I can chain filter calls together.




require 'csv'

# There are 2 types of files that will be passed. The difference between
# them is the columns count and some labeling.

class DinoDex

  attr_reader :all_dinosaurs, :data_source_A, :data_source_B

  def initialize(opts={})
    @all_dinosaurs = Array.new
    @data_source_A = opts[:data_source_A]
    @data_source_B = opts[:data_source_B]
  end


  def parse_csv_to_array_of_arrays(input_file)
    # Data structures - helper
    data = Array.new

    # Iterate through csv, without csv module, remove new line char and append to array structure
    File.open(input_file).each do |row|
      data << row.sub(/\n/, "").split(",")
    end

    return data
  end

  def seed_dino
    # Parses CSVs, skips headers
    data_A = parse_csv_to_array_of_arrays(@data_source_A).drop(1)
    data_B = parse_csv_to_array_of_arrays(@data_source_B).drop(1)

    # use method to parse to arrays, skips headers
    data_A.each do |row|
      # helper structure
      temp = {}

      # Parses data by slicing the row at an index
      temp[:name]         = row[0]
      temp[:period]       = row[1]
      temp[:continent]    = row[2]
      temp[:diet]         = row[3]
      temp[:weight_lbs]   = row[4].to_i
      temp[:walking]      = row[5]
      temp[:description]  = row[6]

      @all_dinosaurs << temp
    end

    data_B.each do |row|
      # helper structure
      temp = {}

      # Parses data by slicing the row at an index
      temp[:name]         = row[0]
      temp[:period]       = row[1]
      temp[:continent]    = nil
      temp[:diet]         = row[2] == "Yes" ? "Carnivore" : nil
      temp[:weight_lbs]   = row[3].to_i
      temp[:walking]      = row[4]
      temp[:description]  = nil

      @all_dinosaurs << temp
    end

    return @all_dinosaurs
  end

  def query_data(filter_criteria={})
    # Helper data structure
    temp = []

    p filter_criteria

    @all_dinosaurs.each do | dino |
      filter_criteria.each do | key , value |
        if dino[key] == value
          p "YEAH YEAH YEAH"
          temp << dino
        else
          next
        end
      end
    end
    return temp
  end
end

class Dinosaur

  

end

dino_instance = DinoDex.new({data_source_A: "dinodex.csv",
                             data_source_B: "african_dinosaur_export.csv"})
dino_instance.seed_dino
# dino_instance.all_dinosaurs
query = dino_instance.query_data({walking: "Biped", diet: "Carnivore"})

query.each do |d|
  p d
end
