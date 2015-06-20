require_relative 'commands.rb'

class Help
  def initialize(help_msgs)
    @messages = help_msgs
  end

  def evaluate(params)
    params = 'manual' unless params.size > 0
    return puts Commands.err_cmd(params) unless Commands.valid_cmd?(params)
    puts @messages[params]
  end
end
