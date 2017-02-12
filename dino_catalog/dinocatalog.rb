require './dinobase.rb'
require './dinoshow.rb'

class Dinocatalog
  LARGE_SIZE = 2000
  HANDLERS = {
    '-b' => :filter_bipeds,
    '-c' => :filter_carnivores,
    '-s' => :filter_small,
    '-B' => :filter_big,
    '--search' => :handle_search,
    '--period' => :handle_period,
  }
  VALID_ARGS = ["-b",
                "-c",
                "--period",
                "-s",
                "-B",
                "--search",
                "--help",
                "--json"]

  def filter_bipeds(dinosaurs, _args)
    dinosaurs.select { |dino| dino['walking'].casecmp('Biped') == 0 }
  end

  def filter_carnivores(dinosaurs, _args)
    dinosaurs.select { |dino| dino['diet'] != 'Herbivore' }
  end

  def filter_small(dinosaurs, _args)
    dinosaurs.select { |dino| dino['weight'].to_i < LARGE_SIZE }
  end

  def filter_big(dinosaurs, _args)
    dinosaurs.select { |dino| dino['weight'].to_i >= LARGE_SIZE }
  end

  def filter_period(dinosaurs, period)
    return [] if period.nil?
    dinosaurs.select do |dino|
      dino['period'].downcase.include? period.downcase
    end
  end

  def value_matches?(field, search_terms)
    field.downcase.include?(search_terms.downcase)
  end

  def dino_matches?(dino, search_terms)
    return [] if search_terms.nil?
    keys = %w(name description period diet continent
              walking weight)
    keys.any? { |key| value_matches?(dino[key], search_terms) }
  end

  def filter_search(dinosaurs, search_terms)
    dinosaurs.select { |dino| dino_matches?(dino, search_terms) }
  end

  def valid_arg?(args)
    args.each do |arg|
      if arg.start_with?("-") && !VALID_ARGS.include?(arg)
        print "*** Invalid Option " + arg + " ***\n"
        return false
      end
    end
    true
  end

  def handle_period(dinosaurs, args)
    index_of_period_arg = args.index("--period")
    period_param = args[index_of_period_arg + 1]
    filter_period(dinosaurs, period_param)
  end

  def handle_search(dinosaurs, args)
    index_of_search_arg = args.index("--search")
    search_param = args[index_of_search_arg + 1]
    filter_search(dinosaurs, search_param)
  end

  def handle_print(args, dinosaurs)
    if args.include? "--json"
      Dinoshow.print_json(dinosaurs)
    else
      Dinoshow.print_text(dinosaurs)
    end
  end

  def handle_params(args, dinosaurs)
    args.each do |arg|
      handler = HANDLERS[arg]
      dinosaurs = send(handler, dinosaurs, args) if handler
    end
    dinosaurs
  end

  def args_invalid?(args)
    if args.include?("--help") || !valid_arg?(args)
      Dinoshow.print_usage
      return true
    end
    false
  end

  def main(args)
    return if args_invalid?(args)
    dinodatabase = Dinobase.new

    dinodatabase.parse_all

    dinosaurs = Array.new(dinodatabase.dinosaurs)
    dinosaurs = handle_params(args, dinosaurs)
    handle_print(args, dinosaurs)
  end
end

# creating a new dinocall and passing args
dinocall = Dinocatalog.new
dinocall.main(ARGV)
