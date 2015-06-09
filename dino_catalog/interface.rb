require_relative 'commands.rb'
require_relative 'export_dinos.rb'
require_relative 'help.rb'
require_relative 'input_parser.rb'
require_relative 'list_dinos.rb'

require 'json'

class Interface
  attr_reader :quit

  COMMANDS = %w(help list export exit manual)

  FLAGS = {
    list: %w(-c -d -f -h -n -p -s -w),
    export: %w(-n),
  }

  public

  def initialize(registry, help_msgs, welcome_msg)
    @quit = false
    @help = Help.new(help_msgs)
    @input = InputParser.new

    @list = ListDinos.new(registry)
    @export = ExportDinos.new(registry)

    puts welcome_msg
  end

  def read(prompt = ":>")
    print prompt
    input = gets.chomp
    evaluate(input)
  end

  private

  def evaluate(input)
    cmd, params = @input.parse(input)
    return puts Commands.err_cmd(cmd) unless Commands.valid_cmd?(cmd)
    send(cmd.downcase, params)
  end

  def help(params)
    @help.evaluate(params)
  end

  alias_method :manual, :help

  def list(params)
    @list.evaluate(params)
  end

  def export(params)
    @export.evaluate(params)
  end

  def exit(params)
    return puts Commands.err_params(params) if params.size > 0
    @quit = true
  end
end
