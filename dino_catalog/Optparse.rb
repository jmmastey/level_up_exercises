require 'optparse'
require 'ostruct'
require 'pp'
require_relative 'Dinosaur'
require_relative 'CSVParse'
require_relative 'dinodex'

class Optparse
  LARGE_WEIGHT = 2000

  def self.parse(args)
    options = OpenStruct.new
    options.filters = []
    options.dinodexes = []
    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: Optparse.rb [options]"
      opts.separator ""
      opts.separator "Specific options:"

      opts.on(
        "-f",
        "--file [inputCSV]",
        Array,
        "Input the file to be used",
              ) do |f|
        options.dinodexes.clear
        f.each do |file|
          options.dinodexes << Dinodex.new(file)
        end
      end

      opts.on(
        "-a",
        "--all",
        "Display all dinosaurs",
              ) do
        options.dinodexes.each { |dinodex| dinodex.print_all_dinos }
      end

      opts.on(
        "-b",
        "--bipeds",
        "Display all dinosaurs that were bipeds",
        ) do
        options.dinodexes.keep_if { |dino| dino.walking == 'Biped' }
      end

      opts.on(
        "-c",
        "--carnivores",
        "Display all dinosaurs that were carnivores",
        ) do
        options.dinodexes.keep_if { |dino| dino.carnivore == "Yes" }
      end

      opts.on(
        "-C",
        "--non-carnivores",
        "Display all dinosaurs that were carnivores",
        ) do
        options.dinodexes.keep_if { |dino| dino.carnivore != "Yes" }
      end

      opts.on(
        "-p",
        "--period [period]",
        "Display all dinosaurs from a certain period",
        ) do |p|
        options.dinodexes.keep_if do |dino|
          dino.period.downcase.include? p.downcase
        end
      end

      opts.on(
        "-s",
        "--small",
        "Display all small dinosaurs",
        ) do
        options.dinodexes.keep_if do |dino| \
          dino.weight.to_i <= LARGE_WEIGHT && !dino.weight.nil?
        end
      end

      opts.on(
        "-l",
        "--large",
        "Display all large dinosaurs",
        ) do
        options.dinodexes.keep_if { |dino| dino.weight.to_i > LARGE_WEIGHT }
      end
    end
    opt_parser.parse!(args)
    options
  end
end

Optparse.parse(ARGV)
