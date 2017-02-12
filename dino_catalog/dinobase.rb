require 'csv'
require './dinosaur'

class Dinobase
  attr_reader :dinosaurs

  VALID_INTEGER_REGEX = /\A[-+]?\d+\z/

  def initialize
    @dinosaurs = []
    @parsing_recipes = [dinodex_recipe, african_dino_recipe]
  end

  def parse_all
    %w(african, dinodex).each { |name| parse(name) }
  end

  private

  def dinodex_recipe
    {
      'name' => 'dinodex',
      'file_path' => './dinodex.csv',
      'recipe_proc' => proc do |row|
        Dinosaur.new(row[0],
          row[1],
          row[2],
          row[3],
          evaluated_weight(row[4]),
          row[5],
          row[6] ? row[6] : 'N/A')
      end,
    }
  end

  def african_dino_recipe
    {
      'name' => 'african',
      'file_path' => './african_dinosaur_export.csv',
      'recipe_proc' => proc do |row|
        Dinosaur.new(name: row[0],
          period: row[1],
          continent: 'Africa',
          diet: row[2] == 'Yes' ? 'Carnivore' : 'Herbivore',
          weight: evaluated_weight(row[3]),
          walking: row[4],
          description: 'N/A')
      end,
    }
  end

  def evaluated_weight(potential_number)
    (potential_number =~ VALID_INTEGER_REGEX) ? potential_number : 'N/A'
  end

  def recipe_for_name(recipe_name)
    recipe = @parsing_recipes.select do |stored_recipe|
      stored_recipe['name'] == recipe_name
    end
    recipe
  end

  def parse(source_name)
    recipe = recipe_for_name(source_name)
    return if recipe.empty?

    CSV.foreach(recipe[0]['file_path'], headers: :first_row) do |row|
      @dinosaurs.push(recipe[0]['recipe_proc'].call(row))
    end
  end
end
