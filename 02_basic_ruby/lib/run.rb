$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))
require 'dinodex'

dinodex = Dinodex.new(STDOUT)
dinodex.start('..\inputs')
#dinodex.findCSVfiles('..\inputs')
#dinodex.loadCSVfile('..\inputs\dinodex.csv')