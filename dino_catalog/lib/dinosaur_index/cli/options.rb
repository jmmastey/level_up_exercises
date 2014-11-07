require "optparse"

module DinosaurIndex
  class CommandLineInterface
    module Options
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
 
      def option_parser
        @opt_parser
      end

      def setup_option_parser
        @opt_parser = OptionParser.new
        setup_banner_text
        setup_filter_options
        setup_other_options
      end

      def setup_banner_text
        @opt_parser.banner = STRINGS[:banner]
        @opt_parser.separator ""
        @opt_parser.separator "Option summary"
      end

      def setup_filter_options
        @opt_parser.on(*STRINGS[:small_opt_params]) \
          { |_opt| add_filter { weight < LARGE_SIZE_LBS } }

        @opt_parser.on(*STRINGS[:large_opt_params]) \
          { |_opt| add_filter { weight >= LARGE_SIZE_LBS } }

        @opt_parser.on(*STRINGS[:biped_opt_params]) \
          { |_opt| add_filter { posture == :bipedal } }

        @opt_parser.on(*STRINGS[:quadruped_opt_params]) \
          { |_opt| add_filter { posture == :quadrupedal } }

        @opt_parser.on(*STRINGS[:carnivore_opt_params]) \
          { |_opt| add_filter { carnivorous? } }
        
        @opt_parser.on(*STRINGS[:noncarnivore_opt_params]) \
          { |_opt| add_filter { !carnivorous? } }

        @opt_parser.on(*STRINGS[:period_opt_params]) \
          { |_opt, pattern| add_filter { time_period =~ /#{pattern}/i } }

        @opt_parser.on(*STRINGS[:continent_opt_params]) \
          { |_opt, pattern| add_filter { continent =~ /#{pattern}/i } }
      end

      def setup_other_options
        @opt_parser.on(*STRINGS[:json_opt_params]) \
          { |_opt| @output_json = true }

        @opt_parser.on(*STRINGS[:default_setting_opt_params]) \
          { |_opt, setting| update_missing_dino_attribute_defaults(setting) }

        @opt_parser.on(*STRINGS[:filename_opt_params]) \
          { |_opt, filename| store_input_file_with_its_defaults(filename) }

        @opt_parser.on(*STRINGS[:help_opt_params]) do |_opt|
          puts @opt_parser
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
          @missing_dino_attribute_defaults.dup
        )
      end

      def split_default_setting_optarg(opt_arg)
        fieldname, value = opt_arg.split('=', 2)
        raise ArgumentError,
              "Invalid syntax setting default value: #{opt_arg}" unless fieldname
        [fieldname.downcase.to_sym, value]
      end

      def add_filter(&test_code)
        @dinosaur_filters << 
          lambda { |dinosaur| dinosaur.instance_eval(&test_code) }
      end
    end
  end
end
