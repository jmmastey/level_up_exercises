require "optparse"

# Implement command-line options to collect information about files to read and
# filters to apply.
module Dinodex
  class CommandLineInterface < OptionParser

    attr_accessor :input_files  # [[pathname, {default values}]
    attr_accessor :select_large, :select_small
    attr_accessor :select_biped, :select_quadruped
    attr_accessor :select_carnivore, :select_noncarnivore
    attr_accessor :select_continent, :select_period
    attr_accessor :output_json
    
    def initialize

      super 

      @default_values = {}
      @input_files = []

      self.banner = "usage $0 [-f filename]+ ...TBD..."
      separator ""
      separator "Option summary"

      on("-s", "--small", 
         "Select small species") { |_o| @select_small = true }
      on("-l", "--large",
         "Select large species") { |_o| @select_large = true }
      on("-2", "--biped",
         "Select bipedal species") { |_o| @select_biped = true }
      on("-4", "--quadruped",
         "Select quadrupedal species") { |_o| @select_quadruped = true }
      on("-c", "--carnivore",
         "Select carnivorous species") { |_o| @select_carnivore = true }
      on("-n", "--noncarnivore",
         "Select noncarnivorous species") { |_o| @select_noncarnivore = true }
      on("-r", "--region", "continent",
         "Select species by continent") { |c| @select_continent = /#{c}/ }
      on("-p", "--period", "period",
         "Select species by period") { |p| @select_period = /#{p}/ }
      on("-j", "--json",
         "Select JSON output") { |_o| @output_json = true }
      on("-d=MANDATORY", "--default", "field=value",
         "Set default value") { |defstr| set_default_value(defstr) }

      on("-f=MANDATORY", "--file", "filename", "Read dinosaurs from 'filename'") do |f|
        @input_files << [f, @default_values]
      end

      on("-h", "--help", "Show this help") do |_o|
        puts help
        exit 0
      end
    end

    # NOTE: "field=" sets empty string value; "field" alone will delete default
    def set_default_value(opt_arg)
      fieldname, value = split_default_setting_optarg(opt_arg)

      # Don't modify current @default_values; stored w/previous input files
      # Instead duplicate and release, adding new settings to dupl. instead
      @default_values = @default_values.dup   

      if value.nil? then @default_values.delete(fieldname)
      else @default_values[fieldname] = value
      end
    end

    private

    def split_default_setting_optarg(opt_arg)
      fieldname, value = opt_arg.split('=', 2)
      raise ArgumentError.new(
        "Invalid syntax setting default value: #{opt_arg}") unless fieldname
      [fieldname.downcase.to_sym, value]
    end
  end
end
