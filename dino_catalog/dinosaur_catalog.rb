require "json"
require_relative 'dinosaur_parser'
require_relative 'dinosaur_search'
require_relative 'dinosaur'
class DinoCatalog
  def run
    more_than_2k_heavier = DinosaurSearch.new(DinosaurParser.new.parse).filter(
                                    "WEIGHT_IN_LBS" => 2000,
                                    "compare" => "greater",
                                    )
    p Dinosaur.new(more_than_2k_heavier.result_dinosaurs).names
    non_veg = DinosaurSearch.new(DinosaurParser.new.parse).filter(
                                        "DIET"    => %w(Carnivore Insectivore),
                                        "compare" => "equal",
                                        )
    p Dinosaur.new(non_veg.result_dinosaurs).names
    non_veg_and_more_than_2k_heavier = non_veg.filter(
                                               "WEIGHT_IN_LBS" => 2000,
                                               "compare" => "greater",
                                                )
    p Dinosaur.new(non_veg_and_more_than_2k_heavier.result_dinosaurs).names
    p Dinosaur.new(non_veg_and_more_than_2k_heavier.result_dinosaurs).to_json
  end
end

DinoCatalog.new.run
