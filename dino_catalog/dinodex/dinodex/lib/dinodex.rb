$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))
require "dinodex_controller"

dinodex = DinodexController.new(STDOUT)
dinodex.start("../inputs")
dinodex.interaction_loop
