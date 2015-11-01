# User stories:
  # As a user, I want to take in 2 types of csv files and combine the data into one data structure - OK
  # As a user, I want to be able to query my data, with multiple parameters:
    # Grab all the dinosaurs that were bipeds.
    # Grab all the dinosaurs that were carnivores (fish and insects count).
    # Grab dinosaurs for specific periods (no need to differentiate between Early and Late Cretaceous, btw).
    # Grab only big (> 2 tons) or small dinosaurs.
    # Just to be sure, I'd love to be able to combine criteria at will, even better if I can chain filter calls together.


# There are 2 types of files that will be passed. The difference between
# them is the columns count and some labeling.


require_relative 'models/dinodex'
require_relative 'models/dinosaur'


dinodex_instance = DinoDex.new({data_source_A: "csv_data/dinodex.csv",
                             data_source_B: "csv_data/african_dinosaur_export.csv"})
dinodex_instance.seed_dino

dinodex_instance.all_dinosaurs

dinodex_instance.fetch_big

# Includes fish and insects
dinodex_instance.fetch_carnivore

# dinodex_instance.all_dinosaurs.each do |dino|
#   p dino.diet
# end
# query = dino_instance.query_data({walking: "Biped", diet: "Carnivore"})

# query.each do |d|
#   p d
# end
