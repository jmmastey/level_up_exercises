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

    @results = []
    @dinos.each do |dino|
      @results << dino if dino.match?(params)
    end
  end

  def to_json
    json = convert_to_json
    JSON.pretty_generate(json)
  end

  private

  def parse_search_params(criteria)
    params = criteria.split(",")

    begin
      map_to_key_val_pairs(params)
    rescue
      puts "Invalid parameters"
      []
    end
  end

  def map_to_key_val_pairs(params)
    params.map do |param|
      args = param.split("=")
      raise ArgumentError if args[0].nil? || args[1].nil?
      [args[0].strip.downcase, args[1].downcase]
    end
  end

  def convert_to_json
    @dinos.map do |dino|
      vars_to_hash(dino)
    end
  end

  def vars_to_hash(dino)
    hash = {}

    dino.instance_variables.each do |var|
      varname = var[1..-1]
      val = dino.send(varname).to_s
      hash[varname.upcase] = val if val.length > 0
    end

    hash
  end
end
