# User stories:
  # 1 As a user, I want to take in 2 types of csv files and combine the data into one data structure
  #  As a user, I want to be able to query my data, with multiple parameters:
    # 2 Grab all the dinosaurs that were bipeds.
    # 3 Grab all the dinosaurs that were carnivores (fish and insects count).
    # 4 Grab dinosaurs for specific periods (no need to differentiate between Early and Late Cretaceous, btw).
    # 5AB Grab only big (> 2 tons) or small dinosaurs.
    # 6 Just to be sure, I'd love to be able to combine criteria at will, even better if I can chain filter calls together.

require_relative 'models/dinodex'
require_relative 'models/dinosaur'

dinodex_instance = DinoDex.new({data_source_A: "csv_data/dinodex.csv",
                             data_source_B: "csv_data/african_dinosaur_export.csv"})
# 1) OK As a user, I want to take in 2 types of csv files and combine the data into one data structure
dinodex_instance.seed

# 2) OK Grab all the dinosaurs that were bipeds
dinodex_instance.fetch_biped

# 3) OK Grab all the dinosaurs that were carnivores (fish and insects count)
dinodex_instance.fetch_carnivore

# 4) OK Grab dinosaurs for specific periods (no need to differentiate between Early and Late Cretaceous, btw).
dinodex_instance.fetch_period("Triassic")

# 5A) OK Grab only big (> 2 tons) or small dinosaurs.
dinodex_instance.fetch_big

# 5B) OK Grab only big (> 2 tons) or small dinosaurs.
dinodex_instance.fetch_small

# 6) combine criteria at will, even better if I can chain filter calls together.
# dinodex_instance.master_fetch({fetch_biped: true, fetch_period: "Triassic"})
