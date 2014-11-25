require "json"
require_relative 'dinosaur_parser'
require_relative 'dinosaur_search'

class DinoCatalog
  def run
    resultant_dinosaurs = DinosaurParser.new.parse
    more_than_2k_heavier = DinosaurSearch.new(resultant_dinosaurs).filter(
                                    "WEIGHT_IN_LBS" => 2000,
                                    "compare" => "greater",
                                    )
    p more_than_2k_heavier.names
    carnivore_and_insectivore = DinosaurSearch.new(resultant_dinosaurs).filter(
                                        "DIET"    => %w(Carnivore Insectivore),
                                        "compare" => "equal",
                                        )
    p carnivore_and_insectivore.names
    non_veg_and_more_than_2k_heavier = carnivore_and_insectivore.filter(
                                               "WEIGHT_IN_LBS" => 2000,
                                               "compare" => "greater",
                                                )
    p non_veg_and_more_than_2k_heavier.names
  end
end

DinoCatalog.new.run
