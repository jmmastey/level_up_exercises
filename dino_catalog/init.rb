#### Dinosaur Catalog ####
# Launch this Ruby file from the command line to initiate the program

APP_ROOT = File.dirname(__FILE__)

$:.unshift( File.join(APP_ROOT, 'lib') ) # load the lib directory

require 'catalog'
require 'app'

app = App.new("dinodex.csv")

if ARGV.size == 1
  app.launch!(ARGV.shift)
else
    puts "\nPlease enter the filename of the CSV to import\n\n"
    puts "Enter 'quit' or 'exit' to leave the program.\n\n"
    print ">>  "
    user_file = gets.chomp
    if user_file == 'quit' || user_file == 'exit'
       puts "\n\nExiting.\n\n"
       exit!
    else
       app.launch!(user_file)
    end
end


