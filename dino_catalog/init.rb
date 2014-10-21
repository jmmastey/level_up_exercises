#### Dinosaur Catalog ####
# Launch this Ruby file from the command line to initiate the program

APP_ROOT = File.dirname(__FILE__)

$:.unshift( File.join(APP_ROOT, 'lib') ) # load the lib directory

require 'catalog'
require 'app'

loop do
  puts "What is the filename of the CSV to import?\n\n"
  puts "Enter 'quit' or 'exit' to leave the program."
  print ">>  "
  filename = gets.chomp
  if filename == 'quit' || filename == 'exit'
    puts "Exiting.\n\n"
    exit!
  else
    app = App.new(filename)
  end
end

catalog.launch!


  # launch the program

  # get the user's input

  # do what the user requests
