require 'optparse'

class DinosaurOptParser
  BOOLEAN_FILTERING_OPTIONS = [
    # [short_flag, long_flag, description, option_flag_key, option_flag_value]
    ['-b', '--biped', "Displays bipeds", :biped, true],
    ['-q', '--quadruped', "Displays quadrupeds", :biped, false],
    ['-c', '--carnivore', "Displays carnivores", :carnivore, true],
    ['-r', '--herbivore', "Displays herbivores", :carnivore, false],
    ['-l', '--big', "Displays big dinosaurs (> 2 TON)", :large, true],
    ['-s', '--small', "Displays small dinosaurs (<= 2 TON)", :large, false],
  ]

  TEXT_FILTERING_OPTIONS = [
    # [short_flag, long_flag, description, option_flag_key]
    ['-g', '--continent CONTINENT', "Displays dinosaurs from CONTINENT", :continent],
    ['-p', '--period PERIOD', "Displays dinosaurs from PERIOD", :period],
  ]

  def initialize
    @options = {}
    @opt_parser = OptionParser.new
  end

  def parse(args)
    set_all_options
    @opt_parser.parse!(args)
    @options
  end

  def set_all_options
    section_header('Input')
    set_input_opts
    section_header('Filtering Options')
    set_boolean_filtering_opts
    set_text_filtering_opts
    section_header('Output')
    set_output_options
    section_header('Help')
    set_help_opts
  end

  private

  def section_header(header)
    @opt_parser.separator("")
    @opt_parser.separator(header)
  end

  def set_opts(short_flag, long_flag, description, &block)
    @opt_parser.on(short_flag, long_flag, description, &block)
  end

  def set_input_opts
    @opt_parser.on('-f', '--file FILE1[,FILE2]', Array,
      "List of CSV files as comma separated string (without spaces)") do |f|
      @options[:files] = f
    end
  end

  def set_boolean_filtering_opts
    BOOLEAN_FILTERING_OPTIONS.each do |filtering_options|
      short, long, desc, key, value = filtering_options
      set_opts(short, long, desc) { @options[key] = value }
    end
  end

  def set_text_filtering_opts
    TEXT_FILTERING_OPTIONS.each do |filtering_options|
      short, long, desc, key = filtering_options
      set_opts(short, long, desc) { |o| @options[key] = o }
    end
  end

  def set_output_options
    @opt_parser.on('-j', '--json [FILE]',
      "Outputs to a JSON file. [default: dinosaurs.json]") do |f|
      @options[:json] = f || 'dinosaurs.json'
    end
  end

  def set_help_opts
    @opt_parser.on_tail('-h', '--help', "Show available options") do
      puts @opt_parser
      exit
    end
  end
end