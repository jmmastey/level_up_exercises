#!/usr/bin/ruby

require "optparse"

require "./dinodex"
require "./dinoparsers.rb"
require "./matching"
require "./jsonparser"
require "./dinoparsestrategy"

def get_options
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: ./main.rb [commands]"

    opts.on("-e", "--export", "export to json") do |_e|
      options[:export] = true
    end

    opts.on("-c", "-command=MANDATORY", "parse the command") do |c|
      options[:command] = c
    end
  end.parse!
  options
end

def main
  options = get_options
  command = (options[:command].nil?) ? STDIN.read : options[:command]

  strategies = [ 
    DinoParseStrategy.new(file_name: "dinodex.csv", dino_parser: DinoParser.new),
    DinoParseStrategy.new(file_name: "african_dinosaur_export.csv", dino_parser: AfroDinoParser.new)
  ]

  dinos = []
  strategies.each {|strategy| dinos += strategy.parse_dinos }

  dinodex = DinoDex.new(dinos)

  token_parser = DinoTokenParser.new
  tokens = token_parser.parse(command)

  result = evaluate(tokens, dinodex)

  if options[:export]
    puts JSONParser.new.dump(result)
  else
    puts result
  end
end

def parse_dinos(file, dino_parser)
  dino_parser.parse(file)
end

def evaluate(tokens, dinodex)
  query = dinodex.new_query
  tokens.each { |token| token.apply_to(query) }
  query.result
end

main
