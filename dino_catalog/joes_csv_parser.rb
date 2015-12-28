require 'csv'
require 'pry'
load 'dino_parser.rb'
class JoesCsvParser < DinoParser
  def initialize(file_name)
    super(file_name)
  end

  def carnivore_values
    ['piscivore','carnivore','insectivore']
  end

  def find_carnivores
    @csv_data.each do |line|
      if(carnivore_values.include?(line[@food_index].downcase))
        @carnivores << line[@map_indices[@fields_mapping[:name].to_sym]]
      end
    end
    print_dinosaurs("Carnivores Dinosaurs", @carnivores)
  end
end

joe = JoesCsvParser.new('/Users/bsubramanian/level_up_exercises/dino_catalog/dinodex.csv')
joe.find_carnivores
joe.find_bipeds
joe.dino_classified_by_periods
joe.classify_by_weight
