require_relative 'dinodex_catalog'
require_relative 'dino_opt_parser'

class DinodexRunner
  attr_accessor :dino_dex, :parsed_options

  def initialize
    @dino_dex = DinoCatalog.new(dino_files: default_dino_files)
    @parsed_options = DinoOptParser.new.parse(ARGV)
  end

  def default_dino_files
    [
      DinoFile.new(path: "dinodex.csv"),
      DinoFile.new(path: "african_dinosaur_export.csv"),
    ]
  end

  def command_missing?
    parsed_options.command.nil?
  end

  def help
    puts DinoOptParser.new.parser
  end

  def execute_command
    return list_dinos if parsed_options.command == :list
    return write_file if parsed_options.command == :write
    return search if parsed_options.command == :search
  end

  def list_dinos
    puts dino_dex.dinosaurs
  end

  def write_file
    dino_dex.export_as_json(parsed_options.filename)
  end

  def search
    search_params = search_params_to_h(parsed_options.list)
    puts dino_dex.search_by_multiple_attrs(search_params)
  end

  def search_params_to_h(params)
    hash = {}
    params.each do |pair|
      key_and_value = pair.split(":")
      hash[key_and_value[0]] = key_and_value[1]
    end
    hash
  end
end
