#!/usr/bin/ruby

require "optparse"

require "./dinodex"
require "./dinoparsers.rb"
require "./matching"
require "./jsonparser"

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

  token_parser = DinoTokenParser.new
  tokens = token_parser.parse(command)

  dino_file_path = "dinodex.csv"
  dino_parser = DinoParser.new
  dinos = dino_parser.parse(dino_file_path)

  afro_dino_file_path = "african_dinosaur_export.csv"
  afro_dino_parser = AfroDinoParser.new
  dinos += afro_dino_parser.parse(afro_dino_file_path)

  dinodex = DinoDex.new(dinos)

  result = evaluate(tokens, dinodex)

  if options[:export]
    puts JSONParser.new.dump(result)
  else
    puts result
  end
end

def evaluate(tokens, dinodex)
  query = tokens.reduce(dinodex.new_query) do |query, token|
    token.execute_token(query)
  end
  query.result
end

main
