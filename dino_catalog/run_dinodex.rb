require_relative 'dinodex'
require_relative 'dinosaur'
require_relative 'parser'

class RunDinodex
  attr_accessor :dinodex
  def initialize
    @dinodex = Dinodex.new(parse_dinos)
  end

  def parse_dinos
    parser = Parser.new
    dinos_hash = parser.parse_dinodex("dinodex.csv")
         .concat parser.parse_african_dinosaurs("african_dinosaur_export.csv")
    dinos_hash.map { |dino| Dinosaur.new(dino) }
  end

  def find
    puts "Dinosaurs with #{ARGV}" unless ARGV.empty?
    ARGV.each do |arg|
      header, value = arg.split(':')
      @dinodex = @dinodex.find_by(header.to_sym, value.downcase)
    end
  end
end

def main
  run_dinodex = RunDinodex.new
  run_dinodex.find
  puts run_dinodex.dinodex
end

main
