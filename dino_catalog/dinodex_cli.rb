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
    
    # Command-line options
    @@opt_s = ["-s", "--small", "Select small species"]
    @@opt_l = ["-l", "--large", "Select large species"]
    @@opt_2 = ["-2", "--biped", "Select bipedal species"]
    @@opt_4 = ["-4", "--quadruped", "Select quadrupedal species"]
    @@opt_c = ["-c", "--carnivore", "Select carnivorous species"]
    @@opt_n = ["-n", "--noncarnivore", "Select noncarnivorous species"]
    @@opt_r = ["-r", "--region", "continent", "Select species by continent"]
    @@opt_p = ["-p", "--period", "period", "Select species by period"]
    @@opt_j = ["-j", "--json", "Select JSON output"]
    @@opt_d = ["-d=MANDATORY", "--default", "field=value", "Set default value"]
    @@opt_h = ["-h", "--help", "Show this help"]
    @@opt_f = ["-f=MANDATORY", "--file", "filename", 
               "Read dinosaurs from 'filename'"]

    def initialize

      super 

      @default_values = {}
      @input_files = []

      self.banner = "usage $0 [-f filename]+ ...TBD..."
      separator ""
      separator "Option summary"

      on(*@@opt_s) { |_o| @select_small = true }
      on(*@@opt_l) { |_o| @select_large = true }
      on(*@@opt_2) { |_o| @select_biped = true }
      on(*@@opt_4) { |_o| @select_quadruped = true }
      on(*@@opt_c) { |_o| @select_carnivore = true }
      on(*@@opt_n) { |_o| @select_noncarnivore = true }
      on(*@@opt_r) { |c| @select_continent = /#{c}/ }
      on(*@@opt_p) { |p| @select_period = /#{p}/ }
      on(*@@opt_j) { |_o| @output_json = true }
      on(*@@opt_d) { |defstr| set_default_value(defstr) }
      on(*@@opt_f) { |f| @input_files << [f, @default_values] }
      on(*@@opt_h) do |_o|
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
