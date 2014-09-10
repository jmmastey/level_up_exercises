$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))
require 'dinodex_controller'

#TODO: handle OS independent paths
dinodex = DinodexController.new(STDOUT)
dinodex.start('..\inputs')
dinodex.interaction_loop


#debugging fun

#dinodex.keyDisplay
#dinodex.findCSVfiles('..\inputs')
#dinodex.loadCSVfile('..\inputs\dinodex.csv')

#dinodex.listDisplay
#dinodex.detailDisplay('Giraffatitan')
#dinodex.filterAndDisplay('walking=biped')
