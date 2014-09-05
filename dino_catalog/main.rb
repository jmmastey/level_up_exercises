#!/usr/bin/ruby

require './dinodex'
require './dinoparsers.rb'
require './matching'
require './jsonparser'

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

  command = (ARGV[0] == nil) ? STDIN.read : ARGV[0]
  tokens = token_parser.parse(command)

  result = evaluate(tokens,dinodex)
  puts JSONParser.new.dump(result)
end


def evaluate(tokens,dinodex)
  query = tokens.reduce(dinodex.new_query) {|query,token| token.execute_token(query)}
  query.result
end

def to_json(result)
  dinos = result.map {|dino| dino.to_json }
  "[" + dinos.join(", ") + "]"
end

main
