
class UserInput

  def self.prompt_user
    puts "Hello. Welcome to DinoDex Catalog.\nPlease choose any or all of the following options- Walking-Biped or Quadriped\nDiet-Insectivore or Carnivore or Piscivore\nWeight-4400 (or specify weight in tonnes)\nContinent-North America, Europe, Asia
    Period-Jurassic or Early or Late.\nElse if you simply know the name of the dinosaur and want all details about it, type in: Information-name_of_dinosaur\n"
  end

  def self.tokenize_user_input(input_string)
    tokenized_string = input_string.split(/[,-]/).each(&:strip!)
    tokenized_string
  end

  def self.search_again
    puts "Do you want to go through the catalog again?"
    response = gets.chomp
    if response.eql?("Y")
      DinoLibrary.new.user_input
    else
     puts "Bye bye!"
   end
  end
end
