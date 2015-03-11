require_relative "dino_csv_parser"
require_relative "dino_printer"
require 'json'

class DinoCatalog
  def initialize
    @dinos = []
    @results = []

    @csv_parser = DinoCsvParser.new
    @printer = DinoPrinter.new

    load_all_csv_files
  end

  def find(criteria)
    @results = []
    params = parse_search_params(criteria)

    return if params.length == 0

    @dinos.each do |dino|
      @results << dino if match?(params, dino)
    end

    print_find_result
  end

  def print_results(params)
    if params.downcase == "all"
      @printer.display(@dinos)
    else
      return printf "\nNo results to print\n" if @results.empty?
      @printer.display(@results)
    end
  end

  def to_json
    json = JSON.pretty_generate(@dinos)
    puts json
  end

  private

  def load_all_csv_files
    Dir["./*.csv"].each do |filename|
      @csv_parser.parse_file(filename)
      @dinos << @csv_parser.dinos
    end

    @dinos.flatten!
  end

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

      [args[0].strip, args[1].strip]
    end
  end

  def print_find_result
    printf "\nFound #{@results.length} match(es): "
    matches = @results.map { |dino| dino["NAME"] }
    puts matches.join(", ")
  end

  def match?(params, dino)
    params.each do |param|
      key = param[0].upcase
      val = param[1].downcase
      return false unless match_one?(key, val, dino)
    end

    true
  end

  def match_one?(key, val, dino)
    case key
      when "DIET"
        match_diet?(val, dino)
      when "WEIGHT"
        match_weight?(val, dino)
      else
        dino[key] ? dino[key].downcase.index(val) : false
    end
  end

  def match_diet?(diet, dino)
    dino_val = dino["DIET"].downcase

    if diet == "carnivore"
      return true if carnivore?(dino_val)
    else
      return true if diet == dino_val
    end

    false
  end

  def carnivore?(val)
    if val == "carnivore" || val == "insectivore" || val == "piscivore"
      return true
    end

    false
  end

  def match_weight?(weight, dino)
    dino_weight = dino["WEIGHT"].to_i

    return false if dino_weight == 0

    return true if big_or_small?(weight, dino_weight)
    return true if weight.to_i == dino_weight

    false
  end

  def big_or_small?(weight, dino_weight)
    return true if weight == "big" && dino_weight > 4000
    return true if weight == "small" && dino_weight <= 4000
    false
  end
end
