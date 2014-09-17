
require 'colorize'

#################
# Module: Details
# ---------------
#
# Usage:
# Details.on
# Details["A message to display when I have Details switched on"]


module Details
  @activated = false

  def Details.turn_on
    @activated = true
  end

  def Details.turn_off
    @activated = false
  end

  def Details.[](msg)
    if @activated
      puts "DETAILS ".green + msg
    end
  end
end
