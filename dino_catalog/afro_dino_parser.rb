require 'csv'
load 'dino_parser.rb'
class AfroDinoParser < DinoParser
  def initialize(file_name)
    super(file_name)
  end

  def classify_by_carnivores
    @csv_data.each do |line|
      if((line[@food_index]) == 'Yes')
        @carnivores << line[@map_indices[@fields_mapping[:name].to_sym]]
      end
    end
    return @carnivores
  end
end

#afro = AfroDinoParser.new('/Users/bsubramanian/level_up_exercises/dino_catalog/african_dinosaur_export.csv')
