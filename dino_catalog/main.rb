#!/usr/bin/ruby

require "optparse"
require "json"

require "./dinodex"
require "./dinoparsers.rb"
require "./jsonparser"
require "./dinoparsestrategy"

def get_options
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: ./main.rb [commands]"

    opts.on("-e", "--export", "export to json") do
      options[:export] = true
    end

    opts.on("-c", "-command=MANDATORY", "parse the command") do |c|
      options[:command] = c
    end
  end.parse!
  options
end

def parse_strategies
  [
    DinoParseStrategy.new(
      file_name: "dinodex.csv",
      dino_parser: DinoParser.new
    ),
    DinoParseStrategy.new(
      file_name: "african_dinosaur_export.csv",
      dino_parser: AfroDinoParser.new
    )
  ]
end

def dinos
  dinos = []
  parse_strategies.each { |strategy| dinos += strategy.parse_dinos }
  dinos
end

def main
  options = get_options

  command_parser = DinoCommandParser.new
  command_text = (options[:command].nil?) ? STDIN.read : options[:command]
  commands = command_parser.parse(command_text)

  dinodex = DinoDex.new(dinos)
  result = dinodex.perform_query(commands)

  if options[:export]
    puts JSON.dump(result)
  else
    puts result
  end
end

main
