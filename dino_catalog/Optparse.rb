require 'optparse'
require 'ostruct'
require 'pp'
require_relative 'Dinosaur.rb'
require_relative 'CSVParse.rb'
require_relative 'dinodex.rb'

class Optparse

  LARGE_WEIGHT = 2000

  def self.parse(args)

    options = OpenStruct.new
    options.filters = []
    options.dinosaurs = []
    parser = CSVParse.new
    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: Optparse.rb [options]"
      opts.separator ""
      opts.separator "Specific options:"

      opts.on(
        "-f",
        "--file [inputCSV]",
        Array,
        "Input the file to be used"
              ) do |f|
        options.dinosaurs.clear
        f.each do |file|
          options.dinosaurs = Dinodex.new(file)
        end
      end

      opts.on(
        "-a",
        "--all",
        "Display all dinosaurs"
              ) do
        options.dinosaurs.each do |dino|
          dino.all_variables.each do |attri|
            puts "-------------"
            puts attri
            puts "-------------"
          end
          puts "\n------------------\n\n"
        end
      end

      opts.on(
        "-b",
        "--bipeds",
        "Display all dinosaurs that were bipeds"
        ) do
        options.dinosaurs.keep_if { |dino| dino.walking == 'Biped' }
      end

      opts.on(
        "-c",
        "--carnivores",
        "Display all dinosaurs that were carnivores"
        ) do
        options.dinosaurs.keep_if { |dino| dino.carnivore == "Yes" }
      end

      opts.on(
        "-C",
        "--non-carnivores",
        "Display all dinosaurs that were carnivores"
        ) do
        options.dinosaurs.keep_if { |dino| dino.carnivore != "Yes" }
      end

      opts.on(
        "-p",
        "--period [period]",
        "Display all dinosaurs from a certain period"
        ) do |p|
        options.dinosaurs.keep_if { |dino| dino.period.downcase.include? p.downcase }
      end

      opts.on(
        "-s",
        "--small",
        "Display all small dinosaurs"
        ) do
        options.dinosaurs.keep_if { |dino| dino.weight.to_i <= LARGE_WEIGHT && !dino.weight.nil? }
      end

      opts.on(
        "-l",
        "--large",
        "Display all large dinosaurs"
        ) do
        options.dinosaurs.keep_if { |dino| dino.weight.to_i > LARGE_WEIGHT }
      end
    end
    opt_parser.parse!(args)
    options
  end
end

options = Optparse.parse(ARGV)
