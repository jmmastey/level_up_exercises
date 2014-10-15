require "optparse"
require "queriable_array"

# Implement command-line options to collect information about files to read and
# to build a filter for a list of dinosaurs
module Dinodex
  class CommandLineInterface < OptionParser

    attr_accessor :input_files  # [[pathname, {default values}]
    attr_accessor :filtering_list
    attr_accessor :output_json

    @@opt_s = ["-s", "--small", "Select small species"]
    @@opt_l = ["-l", "--large", "Select large species"]
    @@opt_2 = ["-2", "--biped", "Select bipedal species"]
    @@opt_4 = ["-4", "--quadruped", "Select quadrupedal species"]
    @@opt_c = ["-c", "--carnivore", "Select carnivorous species"]
    @@opt_n = ["-n", "--noncarnivore", "Select noncarnivorous species"]
    @@opt_j = ["-j", "--json", "Select JSON output"]
    @@opt_h = ["-h", "--help", "Show this help"]
    @@opt_p = ["-p=MANDATORY", "--period", "period", "Select species by period"]
    @@opt_d = ["-d=MANDATORY", "--default", "field=value", "Set default value"]
    @@opt_r = ["-r=MANDATORY", "--region", "continent",
               "Select species by continent"]
    @@opt_f = ["-f=MANDATORY", "--file", "filename", 
               "Read dinosaurs from 'filename'"]

    def initialize

      super 

      @default_values = {}
      @input_files = []
      @filtering_list = QueriableArray.new

      self.banner = "usage $0 [-f filename]+ ...TBD..."
      separator ""
      separator "Option summary"

      on(*@@opt_s) { |_o| add_small_filter }
      on(*@@opt_l) { |_o| add_large_filter }
      on(*@@opt_2) { |_o| add_biped_filter }
      on(*@@opt_4) { |_o| add_quadruped_filter }
      on(*@@opt_c) { |_o| add_carnivore_filter }
      on(*@@opt_n) { |_o| add_noncarnivore_filter }
      on(*@@opt_r) { |continent_pattern| add_region_filter(continent_pattern) }
      on(*@@opt_p) { |period_pattern| add_timeperiod_filter(period_pattern) }
      on(*@@opt_j) { |_o| @output_json = true }
      on(*@@opt_d) { |defstr| set_default_value(defstr) }
      on(*@@opt_f) { |f| @input_files << [f, @default_values] }
      on(*@@opt_h) { |_o| output_help_and_exit }
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

    def add_small_filter
      @filtering_list = @filtering_list.between(:weight, 0, LARGE_SIZE_LBS)
    end

    def add_large_filter
      add_small_filter.negate
    end

    def add_carnivore_filter
      @filtering_list = @filtering_list.match(:carnivore?, true)
    end

    def add_noncarnivore_filter
      add_carnivore_filter.negate
    end

    def add_quadruped_filter
      @filtering_list = @filtering_list.match(:ambulation, 
                                              Ambulation.QUADRUPEDAL)
    end

    def add_biped_filter
      @filtering_list = @filtering_list.match(:ambulation, Ambulation.BIPEDAL)
    end

    def add_region_filter(pattern)
      @filtering_list = 
        @filtering_list.match_regex(:continent, /#{pattern}/i)
    end

    def add_timeperiod_filter(pattern)
      @filtering_list = 
        @filtering_list.match_regex(:time_period, /#{pattern}/i)
    end

    def output_help_and_exit(exitcode = 0)
      puts help
      exit exitcode
    end
  end
end
