#### Dinosaur Catalog ####
# Launch this Ruby file from the command line to initiate the program

APP_ROOT = File.dirname(__FILE__)

$:.unshift( File.join(APP_ROOT, 'lib') ) # load the lib directory

require 'driver'
