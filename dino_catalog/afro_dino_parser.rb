require 'csv'
require 'pry'
load 'dino_parser.rb'
class AfroDinoParser < DinoParser
  def initialize(file_name)
    super(file_name)
  end

  def find_carnivores
    @csv_data.each do |line|
      if((line[@food_index]) == 'Yes')
        @carnivores << line[@map_indices[@fields_mapping[:name].to_sym]]
      end
    end
    print_dinosaurs("Carnivores Dinosaurs", @carnivores)
  end
end

afro = AfroDinoParser.new('/Users/bsubramanian/level_up_exercises/dino_catalog/african_dinosaur_export.csv')
afro.find_carnivores
afro.find_bipeds
afro.dino_classified_by_periods
afro.classify_by_weight
