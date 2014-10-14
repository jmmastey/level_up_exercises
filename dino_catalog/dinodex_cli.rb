require "optparse"

# Implement command-line options to collect information about files to read and
# filters to apply.
module Dinodex
  class CommandLineInterface < OptionParser

    attr_accessor :input_files 
    attr_accessor :select_large, :select_small
    attr_accessor :select_biped, :select_quadruped
    attr_accessor :select_carnivore, :select_noncarnivore
    attr_accessor :select_continent, :select_period
    attr_accessor :output_json
    
    def initialize

      super 

      @input_files = []

      oparser = OptionParser.new do |opt|

        opt.banner = "usage $0 [-f filename]+ ...TBD..."
        opt.separator ""
        opt.separator "Option summary"

        opt.on("-s", "--small", 
               "Select small species") { |_o| @select_small = true }
        opt.on("-l", "--large",
               "Select large species") { |_o| @select_large = true }
        opt.on("-2", "--biped",
               "Select bipedal species") { |_o| @select_biped = true }
        opt.on("-4", "--quadruped",
               "Select quadrupedal species") { |_o| @select_quadruped = true }
        opt.on("-c", "--carnivore",
               "Select carnivorous species") { |_o| @select_carnivore = true }
        opt.on("-n", "--noncarnivore",
               "Select noncarnivorous species") { |_o| @select_noncarnivore = true }
        opt.on("-r", "--region", "continent",
               "Select species by continent") { |c| @select_continent = /#{c}/ }
        opt.on("-p", "--period", "period",
               "Select species by period") { |p| @select_period = /#{p}/ }
        opt.on("-f", "--file", "filename",
               "Read dinosaurs from 'filename'") { |f| @input_files << f }
        opt.on("-j", "--json",
               "Select JSON output", { |_o| @output_json = true }
      end
    end


  end
end
