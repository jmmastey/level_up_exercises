require "optparse"
require "queriable_array"

module DinosaurIndex
  class CommandLineInterface < OptionParser
    InputFile = Struct.new(:pathname, :dino_attribute_defaults);

    attr_accessor :input_files  # [[pathname, {default values}], ...]
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
    @@opt_p = ["-p=period", "--period", "Select species by period"]
    @@opt_d = ["-d=field=value", "--default", "Set default value",
              "Omit '=value' to unset default"]
    @@opt_r = ["-r=continent", "--region", "Select species by continent"]
    @@opt_f = ["-f=filename", "--file", "Read dinosaurs from 'filename'"]

    def initialize
      super

      @file_level_dino_attribute_defaults = {}
      @input_files = []
      @filtering_list = QueriableArray.new

      self.banner = "usage #{File.basename($PROGRAM_NAME)} " \
                    "([-d field=val]* [-f filename]+)+ [selection options]*"
      separator ""
      separator "Option summary"

      on(*@@opt_d) { |defstr| update_default_value(defstr) }
      on(*@@opt_f) { |f| store_input_file_with_its_defaults(f) }
      on(*@@opt_s) { |_o| add_small_filter }
      on(*@@opt_l) { |_o| add_large_filter }
      on(*@@opt_2) { |_o| add_biped_filter }
      on(*@@opt_4) { |_o| add_quadruped_filter }
      on(*@@opt_c) { |_o| add_carnivore_filter }
      on(*@@opt_n) { |_o| add_noncarnivore_filter }
      on(*@@opt_r) { |continent_pattern| add_region_filter(continent_pattern) }
      on(*@@opt_p) { |period_pattern| add_timeperiod_filter(period_pattern) }
      on(*@@opt_h) { |_o| output_help_and_exit }
      on(*@@opt_j) { |_o| @output_json = true }
    end

    # NOTE: "field=" sets empty string value; "field" alone will delete default
    def update_default_value(opt_arg)
      fieldname, value = split_default_setting_optarg(opt_arg)

      if value.nil? then @file_level_dino_attribute_defaults.delete(fieldname)
      else @file_level_dino_attribute_defaults[fieldname] = value
      end
    end

    private

    def store_input_file_with_its_defaults(pathname)
      @input_files << InputFile.new(
        pathname,
        @file_level_dino_attribute_defaults.dup
      )
    end

    def split_default_setting_optarg(opt_arg)
      fieldname, value = opt_arg.split('=', 2)
      raise ArgumentError,
            "Invalid syntax setting default value: #{opt_arg}" unless fieldname
      [fieldname.downcase.to_sym, value]
    end

    def add_small_filter
      @filtering_list =
        @filtering_list.between(:weight, 0, LARGE_SIZE_LBS).exclude_nil
    end

    def add_large_filter
      add_small_filter.negate
    end

    def add_carnivore_filter
      @filtering_list = @filtering_list.match(:carnivorous, true).exclude_nil
    end

    def add_noncarnivore_filter
      add_carnivore_filter.negate
    end

    def add_quadruped_filter
      @filtering_list =
        @filtering_list.match(:posture, Posture::QUADRUPEDAL).exclude_nil
    end

    def add_biped_filter
      @filtering_list =
        @filtering_list.match(:posture, Posture::BIPEDAL).exclude_nil
    end

    def add_region_filter(pattern)
      @filtering_list =
        @filtering_list.match_regex(:continent, /^#{pattern}/i)
    end

    def add_timeperiod_filter(pattern)
      @filtering_list =
        @filtering_list.match_regex(:time_period, /^#{pattern}/i)
    end

    def output_help_and_exit(exitcode = 0)
      puts help
      exit exitcode
    end
  end
end
