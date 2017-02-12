require 'csv'
load 'dino_parser.rb'
class JoesCsvParser < DinoParser
  def initialize(file_name)
    super(file_name)
  end

  def carnivore_values
    ['piscivore','carnivore','insectivore']
  end

  def classify_by_carnivores
    @csv_data.each do |line|
      if(carnivore_values.include?(line[@food_index].downcase))
        @carnivores << line[@map_indices[@fields_mapping[:name].to_sym]]
      end
    end 
    return @carnivores
  end
end

#joe = JoesCsvParser.new('/Users/bsubramanian/level_up_exercises/dino_catalog/dinodex.csv')
