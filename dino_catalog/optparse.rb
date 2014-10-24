require 'optparse'
require 'optparse/time'
require 'ostruct'
require 'pp'

class Optparse


  #
  # Return a structure describing the options.
  #
  def self.parse(args)
    # The options specified on the command line will be collected in *options*.
    # We set default values here.
    options = OpenStruct.new
    options.files = []

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: dinodex.rb [options]"

      opts.separator ""
      opts.separator "Specific options:"

      # Mandatory argument.
      opts.on("-f", "--file FILE",
              "Requires the CSV file before running") do |file|
        options.files << file
      end

      opts.on("-c", "--carnivore", "Carnivore Diet") do |time|
        options.Diet = "Carn"
      end

      opts.on("-v", "--vegetarian", "Vegetarian Diet") do |time|
        options.Diet = "Veg"
      end

      opts.on("-b", "--biped", "Biped Walking") do |time|
        options.Walking = "Biped"
      end

      opts.on("-q", "--quad", "Quadruped Walking") do |time|
        options.Walking = "Quadruped"
      end

      opts.on("-i", "--big", "Big weight (Over 2 Tons)") do |time|
        options.Weight = "Big"
      end

      opts.on("-s", "--small", "Small weight (Under 2 Tons)") do |time|
        options.Weight = "Small"
      end

      opts.on("-a", "--albian", "Time Period: Albian") do |time|
        options.Period = "Albian"
      end

      opts.on("-r", "--cretaceous", "Time Period: Cretaceous") do |time|
        options.Period = "Cretaceous"
      end

      opts.on("-j", "--jurassic", "Time Period: Jurassic") do |time|
        options.Period = "Jurassic"
      end

       opts.on("-o", "--oxfordian", "Time Period: Oxfordian") do |time|
        options.Period = "Oxfordian"
      end

      opts.on("-p", "--permian", "Time Period: Permian") do |time|
        options.Period = "Permian"
      end

      opts.on("-t", "--triassic", "Time Period: Triassic") do |time|
        options.Period = "Triassic"
      end


      #

      opts.separator ""
      opts.separator "Common options:"

      # No argument, shows at tail.  This will print an options summary.
      # Try it and see!
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end

    end

    opt_parser.parse!(args)
    options
  end  # parse()

end  # class OptparseExample

