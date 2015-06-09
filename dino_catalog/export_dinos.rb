require_relative 'commands.rb'
require_relative 'file_system.rb'
require_relative 'input_parser.rb'

class ExportDinos
  FLAGS = %w(-n)

  public

  def initialize(registry)
    @input = InputParser.new
    @fs = FileSystem.new
    @registry = registry
  end

  def evaluate(params)
    flags = @input.extract_flags(params)
    flags.each do |flag|
      return puts Commands.err_flag(flag) unless FLAGS.include?(flag.first)
    end
    export_registry(get_filename(flags))
  end

  private

  def export_registry(filename)
    dir = @fs.pwd + '/exports'
    @fs.create_dir(dir)
    file = dir + "/#{filename}.json"
    @fs.write(@registry.json_string("properties_hash"), file)
    puts "> File successfully saved to #{file}"
  end

  def dinodex_json_string
    @registry.json_string("properties_hash")
  end

  def get_filename(flags)
    flags.inject("export") do |_memo, flag|
      flag.last if flag.first == "-n"
    end
  end
end
