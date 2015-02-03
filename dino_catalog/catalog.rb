require 'csv'
require 'terminal-table'
require_relative 'dinosaur'
require_relative 'dino_list'

def reset_arr(original)
  d_arr = DinoList.new
  original.each { |d| d_arr << d.dup }
  d_arr.is_pirate_list = original.is_pirate_list

  d_arr
end

dino_arr = DinoList.new
original_array = DinoList.new

CSV.foreach(ARGV[0], headers: true) do |row|
  dino_arr.is_pirate_list |= !row.header?('DESCRIPTION')

  new_dino = Dinosaur.new
  new_dino.name = row['Genus'] || row['NAME']
  new_dino.period = row['Period'] || row['PERIOD']
  new_dino.continent = row['CONTINENT']
  new_dino.diet = row['DIET'] ||
                  (row['Carnivore'] == 'Yes' ? 'Carnivore' : 'Herbivore')
  new_dino.weight = row['Weight'] || row['WEIGHT_IN_LBS']
  new_dino.walking = row['Walking'] || row['WALKING']
  new_dino.description = row['DESCRIPTION']

  dino_arr << new_dino
end

exit = false
original_array = reset_arr dino_arr

while !exit
  puts "Note: if entering more than one "
  puts "Enter a letter (or multiple) for your choice(s): "
  puts "A) Display all bipeds"
  puts "B) Display all carnivores"
  puts "C) Display all from a time period"
  puts "D) Display all big dinos (> 2 tons)"
  puts "E) Display all small dinos (<= 2 tons)"
  puts "F) Select one dino"
  puts "R) Remove filters"
  puts "Hit enter to view current list"
  puts "Type EXIT to quit"

  user_input = $stdin.gets.chomp.downcase

  exit = true and next if user_input == 'exit'
  dino_arr = reset_arr original_array if user_input.include? 'r'

  dino_arr.get_bipeds if user_input.include? 'a'
  dino_arr.get_carnivores if user_input.include? 'b'

  if user_input.include? 'c'
    puts "Enter the time period you would like to view: "
    period_input = $stdin.gets.chomp.downcase
    dino_arr.get_from_period period_input
  end

  dino_arr.get_big if user_input.include? 'd'
  dino_arr.get_small if user_input.include? 'e'

  if user_input.include? 'f'
    puts "Please enter a dinosaur's name/genus: "
    name_input = $stdin.gets.chomp.downcase

    dino_arr.get_by_name name_input
  end

  puts dino_arr.pretty_print

end
