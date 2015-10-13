require './dinobase.rb'

class Dinocatalog
  LARGE_SIZE = 2000

  def filter_bipeds(dinosaurs)
    new_dino_list = []

    dinosaurs.each do |dino|
      dino_biped_status = dino['walking']

      new_dino_list.push(dino) if dino_biped_status == 'Biped'
    end

    new_dino_list
  end

  def filter_carnivors(dinosaurs)
    new_dino_list = []

    dinosaurs.each do |dino|
      dino_diet_status = dino['diet']

      new_dino_list.push(dino) if dino_diet_status != 'Herbivore'
    end

    new_dino_list
  end

  def filter_small(dinosaurs)
    new_dino_list = []

    dinosaurs.each do |dino|
      dino_size_status = dino['weight']
      next if dino_size_status == 'N/A'

      dino_size_int = dino_size_status.to_i
      new_dino_list.push(dino) if dino_size_int <= LARGE_SIZE
    end

    new_dino_list
  end

  def filter_big(dinosaurs)
    new_dino_list = []

    dinosaurs.each do |dino|
      dino_size_status = dino['weight']
      next if dino_size_status == 'N/A'

      dino_size_int = dino_size_status.to_i
      new_dino_list.push(dino) if dino_size_int >= LARGE_SIZE
    end

    new_dino_list
  end

  def filter_period(dinosaurs, period_string)
    new_dino_list = []

    dinosaurs.each do |dino|
      dino_period = dino['period']
      small_period = period_string.downcase
      new_dino_list.push(dino) if dino_period.downcase.include? small_period
    end

    new_dino_list
  end

  def test_if_value_matches_search(field, search_string)
    field.downcase.include?(search_string.downcase)
  end

  def test_if_dino_matches_search(dino, search_string)
    keys_to_search = %w(name description period diet continent
                        walking weight)
    keys_to_search.each do |key|
      return true if test_if_value_matches_search(dino[key], search_string)
    end
    false
  end

  def filter_search(dinosaurs, search_string)
    new_dino_list = []

    dinosaurs.each do |dino|
      matched = test_if_dino_matches_search(dino, search_string)
      new_dino_list.push(dino) unless matched == false
    end

    new_dino_list
  end

  def text_export(dinosaurs)
    dinosaurs.each do |dino|
      puts "Name: " + dino['name']
      puts "Period: " + dino['period']
      puts "Continent: " + dino['continent']
      puts "Diet: " + dino['diet']
      puts "Weight: " + dino['weight']
      puts "Walking: " + dino['walking']
      puts "Description: " + dino['description']
      puts "---"
    end
  end

  def json_export(dinosaurs)
    is_first_line = true
    print "["
    dinosaurs.each do |dino|
      unless is_first_line
        print ","
        is_first_line = false
      end
      print "{"
      print "\"name\":" + "\"" + dino['name'] + "\","
      print "\"period\":" + "\"" + dino['period'] + "\","
      print "\"continent\":" + "\"" + dino['continent'] + "\","
      print "\"diet\":" + "\"" + dino['diet'] + "\","
      print "\"weight\":" + "\"" + dino['weight'] + "\","
      print "\"walking\":" + "\"" + dino['walking'] + "\","
      print "\"description\":" + "\"" + dino['description'] + "\""
      print "}"
    end
    print "]"
  end

  def arg_does_not_exist(args)
    list_of_valid_arg = ["-b",
                         "-c",
                         "--period",
                         "-s",
                         "-B",
                         "--search",
                         "--help",
                         "--json"]

    args.each do |arg|
      if arg.start_with?("-") && !list_of_valid_arg.include?(arg)
        print "*** Invalid Option " + arg + " ***\n"
        return true
      end
    end

    false
  end

  def display_usage
    puts "ruby dinocatalog.rb <options>"
    puts "Options are: "

    puts "-b         Sort to show only bipeds dinosaurs"
    puts "-c         Sort to show only carnivores dinosaurs"
    puts "--period period      Sort to show dinosaurs which lived during period"
    puts "-s         Sort to only show small dinosaurs"
    puts "-B         Sort to only show big dinosaurs"
    puts "--search pattern    Search for pattern in the database"
    puts "--help        Shows this usage/help message"
    puts "--json         Export results in JSON"
  end

  def handle_posture(args, final_dinosaurs_list)
    if args.include? "-b"
      final_dinosaurs_list = filter_bipeds(final_dinosaurs_list)
    end
    final_dinosaurs_list
  end

  def handle_diet(args, final_dinosaurs_list)
    if args.include? "-c"
      final_dinosaurs_list = filter_carnivors(final_dinosaurs_list)
    end
    final_dinosaurs_list
  end

  def handle_size(args, final_dinosaurs_list)
    if args.include? "-s"
      final_dinosaurs_list = filter_small(final_dinosaurs_list)
    elsif args.include? "-B"
      final_dinosaurs_list = filter_big(final_dinosaurs_list)
    end
    final_dinosaurs_list
  end

  def handle_period(args, final_dinosaurs_list)
    if args.include? "--period"
      index_of_period_arg = args.index("--period")
      period_param = args[index_of_period_arg + 1]

      final_dinosaurs_list = filter_period(final_dinosaurs_list, period_param)
    end
    final_dinosaurs_list
  end

  def handle_search(args, final_dinosaurs_list)
    if args.include? "--search"
      index_of_search_arg = args.index("--search")
      search_param = args[index_of_search_arg + 1]

      final_dinosaurs_list = filter_search(final_dinosaurs_list, search_param)
    end
    final_dinosaurs_list
  end

  def handle_export(args, final_dinosaurs_list)
    if args.include? "--json"
      json_export(final_dinosaurs_list)
    else
      text_export(final_dinosaurs_list)
    end
  end

  def handle_params(args, final_dinosaurs_list)
    final_dinosaurs_list = handle_posture(args, final_dinosaurs_list)
    final_dinosaurs_list = handle_diet(args, final_dinosaurs_list)
    final_dinosaurs_list = handle_size(args, final_dinosaurs_list)
    final_dinosaurs_list = handle_period(args, final_dinosaurs_list)
    final_dinosaurs_list = handle_search(args, final_dinosaurs_list)
    final_dinosaurs_list
  end

  def handle_usage_and_decide_if_continue(args)
    if args.include?("--help") || arg_does_not_exist(args)
      display_usage
      return false
    end
    true
  end

  def main(args)
    return unless handle_usage_and_decide_if_continue(args)
    dinodatabase = Dinobase.new

    dinodatabase.parse_all

    final_dinosaurs_list = Array.new(dinodatabase.dinosaurs)
    final_dinosaurs_list = handle_params(args, final_dinosaurs_list)
    handle_export(args, final_dinosaurs_list)
  end
end

# creating a new dinocall and passing args
dinocall = Dinocatalog.new
dinocall.main(ARGV)
