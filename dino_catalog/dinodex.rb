require_relative 'dino_importer'
require_relative 'dino_help'
require_relative 'dino_exporter'
require_relative 'dino_lister'
require_relative 'util/commands'

class Dinodex
  WELCOME_FILE = "views/welcome.txt"
  ALIASES = { "exit" => "quit" }

  def initialize(welcome_file = WELCOME_FILE)
    @dino_data = DinoImporter.new.import
    @exporter = DinoExporter.new(@dino_data)
    @lister = DinoLister.new(@dino_data)
    @help = DinoHelp.new
    @welcome_msg = File.read(filepath(welcome_file))
  end

  def start(prompt = "dino:>")
    puts @welcome_msg
    loop { read(prompt) }
  end

  private

  def evaluate(input)
    cmd, params = parse(input)
    return puts Commands.err_cmd(cmd) unless Commands.valid_cmd?(cmd)
    cmd = ALIASES[cmd] if ALIASES.key?(cmd)
    send(cmd, params)
  end

  def quit(params)
    return puts Commands.err_params(params) if params.size > 0
    exit
  end

  def export(params)
    puts @exporter.export(params)
  end

  def filepath(file)
    File.join(File.expand_path(File.dirname(__FILE__)), file)
  end

  def help(params)
    puts @help.evaluate(params)
  end

  def list(params)
    puts @lister.evaluate(params)
  end

  def read(prompt)
    print prompt + ' '
    evaluate(gets.chomp)
  end

  def parse(input)
    words = input.split(' ')
    [words.shift, words.join(' ')]
  end
end

Dinodex.new.start
