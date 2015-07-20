require 'table_print'
require_relative 'dinosaur_interface'

MENU = <<TEXT
query   - Query dinodex
bipeds  - Bipeds only
carnivores - Carnivores only
periods    - Specific periods only
big        - Only big (2 tons+)
json       - Output JSON
quit       - Quit
>
TEXT

def ask_user_for_csv_filename
  print "Enter the csv filename for the dinosaurs\n> "
  gets.chomp!
end

p 'Welcome to Dinodex (Gotta catch em all)'
dinosaurs = DinosaurInterface.new

puts 'To stop loading files, hit enter'
filename = ' '
until filename.empty?
  filename = ask_user_for_csv_filename
  dinosaurs.add_dinosaurs(filename) unless filename.empty?
end

actions = {
  'query' => dinosaurs.method(:query),
  'bipeds' => dinosaurs.method(:bipeds),
  'carnivores' => dinosaurs.method(:carnivores),
  'periods' => dinosaurs.method(:period),
  'big' => dinosaurs.method(:big),
  'json' => dinosaurs.method(:json),
}

input = ''
until input.eql?('quit')
  puts
  print MENU
  input = gets
  input.chomp!.downcase!

  next unless actions.key?(input)

  result = actions[input].call
  if input.eql?('json')
    p result
  else
    tp result
  end
end
