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

  def configure_parser
    configure_help_usage
    configure_help_examples
    configure_help_options_header
    configure_dinosaur_data_related_options
    configure_help_option
    configure_abbreviation_descriptions
  end

  def configure_help_usage
    parser.banner = "Usage: ruby dinodex.rb [options]"
  end

  def configure_help_examples
    parser.separator ""
    parser.separator "Example:"
    parser.separator "    ruby dinodex.rb -s period:jurassic,size:big"
  end

  def configure_help_options_header
    parser.separator ""
    parser.separator "Options:"
  end

  def configure_dinosaur_data_related_options
    configure_list_dinos_option
    configure_search_option
    configure_write_option
  end

  def configure_list_dinos_option
    parser.on(
      "-l", "--list-dinos", "Display all of the dinosaurs in the dinodex") do
      parsed_options.command = :list
    end
  end

  def configure_search_option
    parser.on(
      "-s", "--search [ATTR:VALUE,...]", Array,
      "Comma-separated list of attribute:value pairs") do |list|
      parsed_options.list = list
      parsed_options.command = :search
    end
  end

  def configure_write_option
    parser.on(
      "-w", "--write [FILENAME]",
      "Write entire dinodex in JSON format to named file") do |filename|
      parsed_options.filename = filename
      parsed_options.command = :write
    end
  end

  def configure_help_option
    parser.on("-h", "--help", "Show this message") do
      puts parser
      exit
    end
  end

  def configure_abbreviation_descriptions
    parser.separator ""
    parser.separator "Abbreviations:"
    explain_attr
    explain_value
  end

  def explain_attr
    text = "  [ATTR] represents the name of a dinosaur attribute."
    valid_attrs = Dinosaur.new.searchable_attrs
    text << "  Can be any of: #{valid_attrs.join(', ')})"
    parser.separator text
  end

  def explain_value
    text = "  [VALUE] represents the desired value of a dinosaur attribute."
    text << "  Value is not case sensitive, but requires an otherwise exact "
    text << "match for all attributes except Period."
    parser.separator text
  end

  def parse(args)
    parser.parse!(args)
    parsed_options
  end
end
