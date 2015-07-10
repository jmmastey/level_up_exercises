require_relative 'parser'
require 'json'

def show_menu
  print "Enter any of the options below\n" \
    "1  - Query dinodex\n" \
    "2  - Output JSON\n" \
    "q  - Quit\n" \
    '> '
end

p 'Welcome to Dinodex (Gotta catch em all)'

csv_file = ARGV[0]
unless csv_file
  print "Enter the csv filename for the dinosaurs (ext optional)\n> "
  csv_file = gets
  csv_file.chomp!
end

parser = Parser.new(csv_file)
dinosaurs = parser.parse

input = ''
until input.eql?('q')
  show_menu
  input = gets
  input.chomp!.downcase!

  case input
    when '1'
      p dinosaurs
    when '2'
      p JSON.generate(dinosaurs)
    when 'q'
      next
    else
      p 'Invalid input...'
      next
  end
end
