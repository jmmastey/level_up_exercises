require_relative "dino_csv_parser"
require_relative "dino_printer"

class DinoCatalog
  def initialize
    @dinos = []
    @categories = nil
    @results = []

    @csv_parser = DinoCsvParser.new
    @printer = DinoPrinter.new

    load_all_csv_files
  end

  def load_all_csv_files
    filenames = Dir["./*.csv"]

    filenames.each do |filename|
      @csv_parser.parse_file(filename)
      @dinos << @csv_parser.dinos
    end

    @dinos.flatten!
  end

  def parse_search_params(criteria)
    begin
      params = criteria.split(",")
      parsed_params = params.map do |param|
        args = param.split(/[=<>]/)
        [args[0], args[1]]
      end
    rescue
      puts "Invalid parameters"
      parsed_params = []
    end

    parsed_params
  end

  def find(criteria)
    if criteria.length == 0
      puts "You must enter search criteria for the find command"
      return
    end

    @results = []
    params = parse_search_params(criteria)

    @dinos.each do |dino|
      @results << dino if match?(params, dino)
    end

    print_find_result
  end

  def print_find_result
    puts ""
    print "Found #{@results.length} match(es): "
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
    val = dino["DIET"]

    if diet == "carnivore"
      return true if carnivore?(val)
    else
      return true if diet == val
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
    val = dino["WEIGHT"].to_i

    return false if val == 0

    return true if weight == "big" && val.to_i > 4000
    return true if weight == "small" && val.to_i <= 4000
    return true if weight.to_i == val.to_i

    false
  end

  def print_results(params)
    if params.downcase == "all"
      @printer.display(@dinos)
    else
      return printf "\nNo results to print\n" if @results.empty?
      @printer.display(@results)
    end
  end
end
