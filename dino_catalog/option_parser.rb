require 'optparse'
require 'optparse/time'
require 'ostruct'
require 'pp'

class OptionParser
  def self.parse(args)
    # The options specified on the command line will be collected in *options*.
    # We set default values here.
    options = OpenStruct.new
    options.files = []

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: dinodex.rb [options]"

      opts.separator ""
      opts.separator "Specific options:"

      opts.on("-f", "--file FILE", "Requires the CSV file") do |file|
        options.files << file
      end

      opts.on("-c", "--carnivore", "Carnivore Diet") do
        options.Diet = "Carn"
      end

      opts.on("-v", "--vegetarian", "Vegetarian Diet") do
        options.Diet = "Veg"
      end

      opts.on("-b", "--biped", "Biped Walking") do
        options.Walking = "Biped"
      end

      opts.on("-q", "--quad", "Quadruped Walking") do
        options.Walking = "Quadruped"
      end

      opts.on("-i", "--big", "Big weight (Over 2 Tons)") do
        options.Weight = "Big"
      end

      opts.on("-s", "--small", "Small weight (Under 2 Tons)") do
        options.Weight = "Small"
      end

      opts.on("-a", "--albian", "Time Period: Albian") do
        options.Period = "Albian"
      end

      opts.on("-r", "--cretaceous", "Time Period: Cretaceous") do
        options.Period = "Cretaceous"
      end

      opts.on("-j", "--jurassic", "Time Period: Jurassic") do
        options.Period = "Jurassic"
      end

      opts.on("-o", "--oxfordian", "Time Period: Oxfordian") do
        options.Period = "Oxfordian"
      end

      opts.on("-p", "--permian", "Time Period: Permian") do
        options.Period = "Permian"
      end

      opts.on("-t", "--triassic", "Time Period: Triassic") do
        options.Period = "Triassic"
      end

      opts.separator ""
      opts.separator "Common options:"

      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end

    end

    opt_parser.parse!(args)
    options
  end
end
