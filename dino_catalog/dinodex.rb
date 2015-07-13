require 'table_print'
require_relative 'dinosaur_loader'

MENU =
  ['query       - Query dinodex',
   'bipeds      - Bipeds only',
   'carnivores  - Carnivores only',
   'periods     - Specific periods only',
   'big         - Only big (2 tons+)',
   'json        - Output JSON',
   'quit        - Quit',
   '> ',
  ].join("\n")

def csv_filename
  csv_file = ARGV[0]
  return csv_file if csv_file

  ask_user_for_csv_filename
end

def ask_user_for_csv_filename
  print "Enter the csv filename for the dinosaurs (ext optional)\n> "
  gets.chomp!
end

p 'Welcome to Dinodex (Gotta catch em all)'
dinosaurs = DinosaurLoader.new(csv_filename)

actions = {}
actions['query'] = dinosaurs.method(:query)
actions['bipeds'] = dinosaurs.method(:walking)
actions['carnivores'] = dinosaurs.method(:carnivore)
actions['periods'] = dinosaurs.method(:period)
actions['big'] = dinosaurs.method(:big)
actions['json'] = dinosaurs.method(:json)

input = ''
until input.eql?('quit')
  puts
  print MENU
  input = gets
  input.chomp!.downcase!

  puts input

  next unless actions.key?(input)

  result = actions[input].call
  if input.eql?('json')
    p result
  else
    tp result
  end
end
