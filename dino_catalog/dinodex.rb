require 'optparse'
require 'ostruct'

require_relative 'dinodex_catalog'

class DinoOptParser
  attr_accessor :parser, :parsed_options

  def initialize
    @parser = OptionParser.new
    @parsed_options = OpenStruct.new
    configure_parser
  end

  def configure_list_dinos_option
    @parser.on(
      "-l", "--list-dinos", "Display all of the dinosaurs in the dinodex") do
      @parsed_options.command = :list
    end
  end

  def configure_abbreviation_descriptions
    @parser.separator ""
    @parser.separator "Abbreviations:"
    explain_attr
    explain_value
  end

  def explain_attr
    text = "  [ATTR] represents the name of a dinosaur attribute."
    valid_attrs = Dinosaur.new.searchable_attrs
    text << "  Can be any of: #{valid_attrs.join(', ')})"
    @parser.separator text
  end

  def explain_value
    text = "  [VALUE] represents the desired value of a dinosaur attribute."
    text << "  Value is not case sensitive, but requires an otherwise exact "
    text << "match for all attributes except Period."
    @parser.separator text
  end

  def configure_write_option
    @parser.on(
      "-w", "--write [FILENAME]",
      "Write entire dinodex in JSON format to named file") do |filename|
      @parsed_options.filename = filename
      @parsed_options.command = :write
    end
  end

  def verify_search_arguments_list_length(list)
    list_length_error = "List must have an even number of elements"
    raise(DinoBadArg, list_length_error) if list.length.odd?
  end

  def configure_search_option
    @parser.on(
      "-s", "--search [ATTR,VALUE,...]", Array,
      "Comma-separated list of attribute,value pairs") do |list|
      verify_search_arguments_list_length(list)
      @parsed_options.list = list
      @parsed_options.command = :search
    end
  end

  def configure_help_option
    @parser.on("-h", "--help", "Show this message") do
      puts @parser
      exit
    end
  end

  def configure_help_usage
    @parser.banner = "Usage: ruby dinodex.rb [options]"
  end

  def configure_help_options_header
    @parser.separator ""
    @parser.separator "Options:"
  end

  def configure_help_examples
    @parser.separator ""
    @parser.separator "Example:"
    @parser.separator "    ruby dinodex.rb -s period,jurassic,size,big"
  end

  def configure_dinosaur_data_related_options
    configure_list_dinos_option
    configure_search_option
    configure_write_option
  end

  def configure_parser
    configure_help_usage
    configure_help_examples
    configure_help_options_header
    configure_dinosaur_data_related_options
    configure_help_option
    configure_abbreviation_descriptions
  end

  def parse(args)
    @parser.parse!(args)
    @parsed_options
  end
end

class DinoBadArg < StandardError
end

class DinoDexRunner
  attr_accessor :dino_dex, :parsed_options

  def initialize
    @dino_dex = DinoCatalog.new(dino_files: default_dino_files)
    @parsed_options = DinoOptParser.new.parse(ARGV)
  end

  def default_dino_files
    [
      DinoFile.new("dinodex.csv", :original),
      DinoFile.new("african_dinosaur_export.csv", :p_b_africa),
    ]
  end

  def list_dinos
    puts @dino_dex.dinosaurs
  end

  def write_file
    dino_dex.write_dinosaurs_as_json_file(parsed_options.filename)
  end

  def search
    attr = nil
    hash = {}
    parsed_options.list.each_with_index do |element, index|
      index.even? ? attr = element : hash[attr] = element
    end
    puts dino_dex.search_by_hash(hash)
  end

  def execute_command
    return list_dinos if @parsed_options.command == :list
    return write_file if @parsed_options.command == :write
    return search if parsed_options.command == :search
  end
end

def main
  runner = DinoDexRunner.new
  runner.execute_command
rescue DinoBadArg => error_message
  puts error_message
end

main
