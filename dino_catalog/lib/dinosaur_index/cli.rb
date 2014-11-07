require "optparse"
require_relative "cli/options"

module DinosaurIndex
  class CommandLineInterface
    include Options

    InputFile = Struct.new(:pathname, :dino_attribute_defaults);

    attr_accessor :input_files, :dinosaur_filters, :output_json, :filter_list

    def initialize
      @missing_dino_attribute_defaults = {}
      @input_files = []
      @filter_list = []
      setup_option_parser
    end

    def parse!(command_line_arguments)
      @opt_parser.parse!(command_line_arguments)
    end
  end
end
