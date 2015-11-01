require_relative 'models/dinodex'
require_relative 'models/dinosaur'
# require_relative 'csv_data'
# require_relative 'csv_data/african_dinosaur_export.csv'


dino_instance = DinoDex.new({data_source_A: "csv_data/dinodex.csv",
                             data_source_B: "csv_data/african_dinosaur_export.csv"})
dino_instance.seed_dino

dino_instance.all_dinosaurs
# query = dino_instance.query_data({walking: "Biped", diet: "Carnivore"})

# query.each do |d|
#   p d
# end
