require "json"
require_relative 'dinosaur_parser'
require_relative 'dinosaur_search'

class DinoCatalog
  def run
    options  = {}
    options1 = {}

    options['WEIGHT_IN_LBS'] = 2000
    options['compare']       = "greater"

    parser = DinosaurParser.new
    resultant_dinosaurs = parser.parse

    dinosaur = DinosaurSearch.new(resultant_dinosaurs)
    result = dinosaur.smart_search_dinosaur(options)

    p result.get_name
    dinosaur1 = DinosaurSearch.new(resultant_dinosaurs)

    options1['DIET'] = ['carnivore', 'insectivore']
    options1['compare'] = "equal"

    result1 = dinosaur1.smart_search_dinosaur(options1)
    p result1.get_name

    result2 = result1.smart_search_dinosaur(options)
    p result2.get_name
  end
end

DinoCatalog.new.run
