require 'json'
require 'table_print'
require_relative 'dinosaur_loader'
require_relative 'dinosaur_query'

def csv_file
  csv_file = ARGV[0]
  puts "test" if csv_file
  return csv_file if csv_file

  ask_user_for_csv_file
end

def ask_user_for_csv_file
  print "Enter the csv filename for the dinosaurs (ext optional)\n> "
  csv_file = gets
  csv_file.chomp!
end

p 'Welcome to Dinodex (Gotta catch em all)'

menu = "Enter any of the options below\n" \
    "\t1  - Query dinodex\n" \
    "\t2  - Bipeds only\n" \
    "\t3  - Carnivores only\n" \
    "\t4  - Specific periods only\n" \
    "\t5  - Only big (2 ton +)]\n" \
    "\t9  - Output JSON\n" \
    "\tq  - Quit\n" \
    '> '

dinosaurs = DinosaurLoader.load(csv_file)

input = ''
until input.eql?('q')
  puts
  print menu
  input = gets
  input.chomp!.downcase!

  case input
    when '1'
      query = DinosaurQuery.new(dinosaurs)
      tp query.process
    when '2'
      tp dinosaurs.select { |dinosaur| dinosaur.filter('walking', 'Biped') }
    when '3'
      tp dinosaurs.select { |dinosaur| dinosaur.filter('diet', 'Carnivore') }
    when '4'
      print "Enter period:\n> "
      value = gets.chomp!
      tp dinosaurs.select { |dinosaur| dinosaur.contains('period', value) }
    when '5'
      tp dinosaurs.select { |dinosaur| dinosaur.greater_than?('weight', 2000) }
    when '9'
      p JSON.generate(dinosaurs.map(&:to_hash))
    when 'q'
      next
    else
      p 'Invalid input...'
      next
  end
end
