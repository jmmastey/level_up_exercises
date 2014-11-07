require "optparse"

module DinosaurIndex
  class CommandLineInterface
    module Options
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
        @opt_parser.banner = "usage #{File.basename($PROGRAM_NAME)} " \
                      "([-d field=val]* [-f filename]+)+ [selection options]*"
        @opt_parser.separator ""
        @opt_parser.separator "Option summary"
      end

      def setup_filter_options
        @opt_parser.on("-s", "--small", "Select small species") \
          { |_opt| add_filter { weight < LARGE_SIZE_LBS } }

        @opt_parser.on("-l", "--large", "Select large species") \
          { |_opt| add_filter { weight >= LARGE_SIZE_LBS } }

        @opt_parser.on("-2", "--biped", "Select bipedal species") \
          { |_opt| add_filter { posture == :bipedal } }

        @opt_parser.on("-4", "--quadruped", "Select quadrupedal species") \
          { |_opt| add_filter { posture == :quadrupedal } }

        @opt_parser.on("-c", "--carnivore", "Select carnivorous species") \
          { |_opt| add_filter { carnivorous? } }
        
        @opt_parser.on("-n", "--noncarnivore", "Select noncarnivorous species") \
          { |_opt| add_filter { !carnivorous? } }

        @opt_parser.on("-p=period", "--period", "Select species by period") \
          { |_opt, pattern| add_filter { time_period =~ /#{pattern}/i } }

        @opt_parser.on("-r=continent", "--region",
                       "Select species by continent") \
          { |_opt, pattern| add_filter { continent =~ /#{pattern}/i } }
      end

      def setup_other_options
        @opt_parser.on("-j", "--json", "Select JSON output") \
          { |_opt| @output_json = true }

        @opt_parser.on("-d=field=value", "--default",
                       "Set default value", "Omit '=value' to unset default") \
          { |_opt, setting| update_file_level_defaults(setting) }

        @opt_parser.on("-f=filename", "--file", "Read dinosaurs from 'filename'") \
          { |_opt, filename| store_input_file_with_its_defaults(filename) }

        @opt_parser.on("-h", "--help", "Show this help") do |_opt|
          puts @opt_parser
          exit 0
        end
      end

      def update_file_level_defaults(opt_arg)
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
        @filter_list << lambda { |dinosaur| dinosaur.instance_eval(&test_code) }
      end
    end
  end
end
