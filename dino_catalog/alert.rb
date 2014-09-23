require 'colorize'

###############
# Module: Alert
# -------------
#
# Alert.disp "A casual message"
# Alert.info "A notification message"
# Alert.warn "A warning message"
# Alert.exit "A failure message"

module Alert
  # Disp
  def Alert.disp(msg = "")
    $stderr.puts "DISP " + msg
  end

  # Info
  def Alert.info(msg = "")
    $stderr.puts ("INFO " + msg).light_blue
  end

  # Warn
  def Alert.warn(msg = "")
    $stderr.puts ("WARN " + msg).yellow
  end
  
  # Exit
  def Alert.exit(msg = "")
    $stderr.puts ("EXIT " + msg).red
    Kernel.exit
  end
end
