require 'csv'

class Dinobase
  attr_reader :dinosaurs
  VALID_INTEGER_REGEX = /\A[-+]?\d+\z/

  def initialize
    @dinosaurs = []
    @parsing_recipes = [dinodex_recipe, african_dino_recipe]
  end

  def dinodex_recipe
    {
      'name' => 'dinodex',
      'file_path' => './dinodex.csv',
      'recipe_proc' => proc do |row|
        { 'name' => row[0],
          'period' => row[1],
          'continent' => row[2],
          'diet' => row[3],
          'weight' => number_or_na(row[4]),
          'walking' => row[5],
          'description' => row[6] ? row[6] : 'N/A' }
      end,
    }
  end

  def african_dino_recipe
    {
      'name' => 'african',
      'file_path' => './african_dinosaur_export.csv',
      'recipe_proc' => proc do |row|
        { 'name' => row[0],
          'period' => row[1],
          'continent' => 'N/A',
          'diet' => row[2] == 'Yes' ? 'Carnivore' : 'Herbivore',
          'weight' => number_or_na(row[4]),
          'walking' => row[4],
          'description' =>
          'Not a lot is known about ' + row[0] + ' at this point.' }
      end,
    }
  end

  def number_or_na(potential_number)
    (potential_number =~ VALID_INTEGER_REGEX) ? potential_number : 'N/A'
  end

  def parse(source_name:)
    @parsing_recipes.each do |recipe|
      if recipe['name'] == source_name
        CSV.foreach(recipe['file_path']) do |row|
          @dinosaurs.push(recipe['recipe_proc'].call(row))
        end
        break
      end
    end
  end

  def parse_all
    parse(source_name: 'african')
    parse(source_name: 'dinodex')
  end
end
