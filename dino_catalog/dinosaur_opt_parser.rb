require 'optparse'

class DinosaurOptParser
  FILTERING_OPTIONS = [
    # [short_flag, long_flag, description, option_flag_key]
    ['-b', '--biped', "Displays bipeds", :biped],
    ['-q', '--quadruped', "Displays quadrupeds", :quadruped],
    ['-c', '--carnivore', "Displays carnivores", :carnivore],
    ['-r', '--herbivore', "Displays herbivores", :herbivore],
    ['-l', '--large', "Displays large dinosaurs (> 2 TON)", :large],
    ['-s', '--small', "Displays small dinosaurs (<= 2 TON)", :small],
    ['-g', '--continent CONTINENT', "Displays dinosaurs from CONTINENT", :continent],
    ['-p', '--period PERIOD', "Displays dinosaurs from PERIOD", :period],
  ]

  DEFAULT_JSON_FILE = 'dinosaurs.json'

  def initialize
    @options = {}
    @opt_parser = OptionParser.new
  end

  def parse(args)
    set_all_options
    @opt_parser.parse!(args)
    @options
  end

  private

  def section_header(header)
    @opt_parser.separator("")
    @opt_parser.separator(header)
  end

  def banner
    @opt_parser.banner = "./main.rb -f FILE1[,FILE2] [Options]"
  end

  def input_opts
    section_header('File Input')

    @opt_parser.on('-f', '--file FILE1[,FILE2]', Array,
      "List of CSV files as comma separated string (without spaces)") do |f|
      @options[:files] = f
    end
  end

  def filtering_opts
    section_header('Filtering Options')

    FILTERING_OPTIONS.each do |filtering_option_row|
      key = filtering_option_row.pop
      @opt_parser.on(*filtering_option_row) { |v| @options[key] = v }
    end
  end

  def output_options
    section_header('Output Options')

    @opt_parser.on('-j', '--json [FILE]',
      "Outputs to a JSON file. [default: dinosaurs.json]") do |f|
      @options[:json] = f || DEFAULT_JSON_FILE
    end
  end

  def help_opts
    section_header('Help')

    @opt_parser.on_tail('-h', '--help', "Show available options") do
      puts @opt_parser
      exit
    end
  end

  def set_all_options
    banner
    input_opts
    filtering_opts
    output_options
    help_opts
  end
end
