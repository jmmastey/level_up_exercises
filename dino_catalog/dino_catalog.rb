require "json"

class DinoCatalog
  attr_accessor :dinos
  attr_reader :results

  def initialize
    @dinos = []
    @results = []
  end

  def find(criteria)
    params = parse_search_params(criteria)
    return if params.length == 0

    @results =  @dinos.select { |dino| dino.match?(params) }
  end

  def to_json
    hash_array = convert_dinos_to_hashes
    JSON.pretty_generate(hash_array)
  end

  private

  def parse_search_params(criteria)
    params = criteria.split(",")
    map_to_key_val_pairs(params)
  rescue
    puts "Invalid parameters"
    []
  end

  def map_to_key_val_pairs(params)
    params.map do |param|
      args = param.split("=")
      raise ArgumentError if args[0].nil? || args[1].nil?
      [args[0].strip.downcase, args[1].downcase]
    end
  end

  def convert_dinos_to_hashes
    @dinos.map { |dino| dino.to_hash }
  end
end
