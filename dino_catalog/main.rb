# User stories:
  # 1 As a user, I want to take in 2 types of csv files and combine the data into one data structure
  #  As a user, I want to be able to query my data, with multiple parameters:
    # 2 Grab all the dinosaurs that were bipeds.
    # 3 Grab all the dinosaurs that were carnivores (fish and insects count).
    # 4 Grab dinosaurs for specific periods (no need to differentiate between Early and Late Cretaceous, btw).
    # 5AB Grab only big (> 2 tons) or small dinosaurs.
    # 6 Just to be sure, I'd love to be able to combine criteria at will, even better if I can chain filter calls together.

  # 7 For a given dino, I'd like to be able to print all the known facts about that dinosaur. If there are facts missing, please don't print empty values, just skip that heading. Make sure to print Early / Late etc for the periods.
  # 8 Also, I'll probably want to print all the dinosaurs in a given collection (after filtering, etc).

  # Extra Credit
    # 9 I would love to have a way to do (and chain) generic search by parameters. I can pass in a hash, and I'd like to get the proper list of dinos back out.
    # 10 CSV isn't may favorite format in the world. Can you implement a JSON export feature?

require_relative 'models/dinodex'
require_relative 'models/dinosaur'

# Please run the tests to confirm the implementation below works.

  # dinodex_instance = DinoDex.new({data_source_A: "csv_data/dinodex.csv",
                               data_source_B: "csv_data/african_dinosaur_export.csv"})
  # 1) OK As a user, I want to take in 2 types of csv files and combine the data into one data structure
  # dinodex_instance.seed

  # # 2) OK Grab all the dinosaurs that were bipeds
  # dinodex_instance.fetch_biped
  #
  # # 3) OK Grab all the dinosaurs that were carnivores (fish and insects count)
  # dinodex_instance.fetch_carnivore
  #
  # # 4) OK Grab dinosaurs for specific periods (no need to differentiate between Early and Late Cretaceous, btw).
  # dinodex_instance.fetch_period("Triassic")
  #
  # # 5A) OK Grab only big (> 2 tons) or small dinosaurs.
  # dinodex_instance.fetch_big
  #
  # # 5B) OK Grab only big (> 2 tons) or small dinosaurs.
  # dinodex_instance.fetch_small
  #
  # # 6) OK combine criteria at will, even better if I can chain filter calls together.
  # dinodex_instance.master_fetch({param1: "fetch_biped",
  #                                param2: "fetch_big"})

  # # 7) OK For a given dino, I'd like to be able to print all the known facts about that dinosaur. If there are facts missing, please don't print empty values, just skip that heading. Make sure to print Early / Late etc for the periods.
  # dinodex_instance.all_dinosaurs[0].display

  # 8) OK Also, I'll probably want to print all the dinosaurs in a given collection (after filtering, etc).
  # dinodex_instance.display_group(small)

  # 9) OK I would love to have a way to do (and chain) generic search by parameters. I can pass in a hash, and I'd like to get the proper list of dinos back out.
    # Already implemented -> master search.

  # 10) OK CSV isn't may favorite format in the world. Can you implement a JSON export feature?
