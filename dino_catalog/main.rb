#!/usr/bin/ruby

require './dinodex'
require './dinoparsers.rb'

def main
  dino_file_path = "dinodex.csv"
  dino_parser = DinoParser.new
  dinos = dino_parser.parse(dino_file_path)

  afro_dino_file_path = "african_dinosaur_export.csv"
  afro_dino_parser = AfroDinoParser.new
  dinos += afro_dino_parser.parse(afro_dino_file_path)

  dinodex = DinoDex.new
  dinodex.load(dinos)

  token_parser = DinoTokenParser.new

  tokens = token_parser.parse(ARGV[0]) 

  puts evaluate(tokens,dinodex)
end


def evaluate(tokens,dinodex)
  query = tokens.reduce(dinodex.new_query) {|query,token| token.execute_token(query)}
  query.result
end

main
