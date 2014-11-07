require "optparse"

module DinosaurIndex
  class CommandLineInterface
    module Options
      include Data
      attr_accessor :dinosaur_catalog
      attr_reader :option_parser

      STRINGS = {
        banner: "usage #{File.basename($PROGRAM_NAME)} ([-d field=val]* [-f filename]+)+ [selection options]*",
        small_opt_params: ["-s", "--small", "Select small species"],
        large_opt_params: ["-l", "--large", "Select large species"],
        biped_opt_params: ["-2", "--biped", "Select bipedal species"],
        quadruped_opt_params: ["-4", "--quadruped", "Select quadrupedal species"],
        carnivore_opt_params: ["-c", "--carnivore", "Select carnivorous species"],
        noncarnivore_opt_params: ["-n", "--noncarnivore", "Select noncarnivorous species"],
        period_opt_params: ["-p=period", "--period", "Select species by period"],
        continent_opt_params: ["-r=continent", "--region", "Select species by continent"],
        json_opt_params: ["-j", "--json", "Select JSON output"],
        default_setting_opt_params: ["-d=field=value", "--default", "Set default value", "Omit '=value' to unset default"],
        filename_opt_params: ["-f=filename", "--file", "Read dinosaurs from 'filename'"],
        help_opt_params: ["-h", "--help", "Show this help"],
      }

      def setup_option_parser
        @option_parser = OptionParser.new
        setup_banner_text
        setup_filter_options
        setup_other_options
      end

      def setup_banner_text
        @option_parser.banner = STRINGS[:banner]
        @option_parser.separator ""
        @option_parser.separator "Option summary"
      end

      def setup_filter_options
        @option_parser.on(*STRINGS[:small_opt_params]) \
          { |_opt| add_filter { weight && weight < LARGE_SIZE_LBS } }

        @option_parser.on(*STRINGS[:large_opt_params]) \
          { |_opt| add_filter { weight && weight >= LARGE_SIZE_LBS } }

        @option_parser.on(*STRINGS[:biped_opt_params]) \
          { |_opt| add_filter { posture && posture == :biped } }

        @option_parser.on(*STRINGS[:quadruped_opt_params]) \
          { |_opt| add_filter { posture && posture == :quadruped } }

        @option_parser.on(*STRINGS[:carnivore_opt_params]) \
          { |_opt| add_filter { carnivorous? } }

        @option_parser.on(*STRINGS[:noncarnivore_opt_params]) \
          { |_opt| add_filter { !carnivorous? } }

        @option_parser.on(*STRINGS[:continent_opt_params]) \
          { |pattern| add_filter { continent && continent =~ /#{pattern}/i } }

        @option_parser.on(*STRINGS[:period_opt_params]) do |pattern|
          add_filter { time_period && time_period =~ /#{pattern}/i }
        end
      end

      def add_filter(&filter_code)
        dinosaur_catalog.add_filter(&filter_code)
      end

      def setup_other_options
        @option_parser.on(*STRINGS[:json_opt_params]) \
          { |_opt| @output_json = true }

        @option_parser.on(*STRINGS[:default_setting_opt_params]) \
          { |setting| update_missing_dino_attribute_defaults(setting) }

        @option_parser.on(*STRINGS[:filename_opt_params]) \
          { |filename| store_input_file_with_its_defaults(filename) }

        @option_parser.on(*STRINGS[:help_opt_params]) do |_opt|
          puts @option_parser
          exit 0
        end
      end

      def update_missing_dino_attribute_defaults(opt_arg)
        fieldname, value = split_default_setting_optarg(opt_arg)

        @missing_dino_attribute_defaults.delete(fieldname) if value.nil?
        @missing_dino_attribute_defaults[fieldname] = value unless value.nil?
      end

      def store_input_file_with_its_defaults(pathname)
        @input_files << InputFile.new(
          pathname,
          @missing_dino_attribute_defaults.dup,
        )
      end

      def split_default_setting_optarg(opt_arg)
        fieldname, value = opt_arg.split('=', 2)
        raise ArgumentError,
              "Invalid default setting syntax: #{opt_arg}" unless fieldname
        [fieldname.downcase.to_sym, value]
      end
    end
  end
end
