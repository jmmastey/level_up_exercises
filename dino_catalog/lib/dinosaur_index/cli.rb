require "optparse"
require_relative "cli/options"

module DinosaurIndex
  class CommandLineInterface
    include Options

    InputFile = Struct.new(:pathname, :dino_attribute_defaults);

    attr_accessor :input_files, :dinosaur_filters, :output_json

    def initialize
      @missing_dino_attribute_defaults = {}
      @dinosaur_filters = []
      @input_files = []
      setup_option_parser
    end

    def parse!(command_line_arguments)
      option_parser.parse!(command_line_arguments)
    end
  end
end
