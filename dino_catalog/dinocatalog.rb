class Dinobase
  attr_reader :dinosaurs
  @debug = true

  def initialize(_args = {})
    @dinosaurs = []
    @debug = false
  end

  def open_and_read_file(file_path)
    file = File.open(file_path, "r")
    data = file.read
    file.close
    data
  end

  def new_entry_for_dinodex_row(row)
    cells = row.split(',')

    new_entry = {}
    new_entry['name'] = cells[0]
    new_entry['period'] = cells[1]
    new_entry['continent'] = cells[2]
    new_entry['diet'] = cells[3]
    new_entry['weight'] = cells[4].to_i != 0 ? cells[4] : 'N/A'
    new_entry['walking'] = cells[5]
    new_entry['description'] = cells[6]

    new_entry
  end

  def parse_dinodex
    csv_path = './dinodex.csv'
    csv_content = open_and_read_file(csv_path)
    line_count = 0
    skipped_first_line = false
    csv_content.each_line do |row|
      # skip the header.
      if skipped_first_line == false
        skipped_first_line = true
        next
      end
      new_entry = new_entry_for_dinodex_row(row)

      @dinosaurs.push(new_entry)
      line_count += 1
    end
    print "Just loaded " + line_count.to_s +
      " Dinosaurs from dinodex\n" if @debug
  end

  def new_entry_for_african_dinos_row(row)
    cells = row.split(',')

    new_entry = {}
    new_entry['name'] = cells[0]
    new_entry['period'] = cells[1]
    new_entry['continent'] = 'N/A'
    new_entry['diet'] = cells[2] == 'Yes' ? 'Carnivore' : 'Herbivore'
    new_entry['weight'] = /\A[-+]?\d+\z/ === cells[3] ? cells[3] : 'N/A'
    new_entry['walking'] = cells[4]
    new_entry['description'] =
    'Not a lot is known about ' + cells[0] + ' at this point.'

    new_entry
  end

  def parse_african_dinos
    csv_path = './african_dinosaur_export.csv'
    csv_content = open_and_read_file(csv_path)

    line_count = 0
    skipped_first_line = false
    csv_content.each_line do |row|
      # skip the header.
      if skipped_first_line == false
        skipped_first_line = true
        next
      end
      new_entry = new_entry_for_african_dinos_row(row)

      @dinosaurs.push(new_entry)
      line_count += 1
    end
    print "Just loaded " + line_count.to_s +
      " Dinosaurs from african dinosaurs\n" if @debug
  end
end

class Dinocalls
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
      new_dino_list.push(dino) if dino_size_int <= 2000
    end

    new_dino_list
  end

  def filter_big(dinosaurs)
    new_dino_list = []

    dinosaurs.each do |dino|
      dino_size_status = dino['weight']
      next if dino_size_status == 'N/A'

      dino_size_int = dino_size_status.to_i
      new_dino_list.push(dino) if dino_size_int >= 2000
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

  def filter_search(dinosaurs, search_string)
    new_dino_list = []

    dinosaurs.each do |dino|

      dino_name = dino['period']
      dino_description = dino['description']
      dino_period = dino['period']
      dino_diet = dino['diet']
      dino_continent = dino['continent']
      dino_walking = dino['walking']
      dino_weight = dino['weight']

      if dino_name.downcase.include?(search_string.downcase) ||
         dino_description.downcase.include?(search_string.downcase) ||
         dino_period.downcase.include?(search_string.downcase) ||
         dino_diet.downcase.include?(search_string.downcase) ||
         dino_continent.downcase.include?(search_string.downcase) ||
         dino_walking.downcase.include?(search_string.downcase) ||
         dino_weight.downcase.include?(search_string.downcase)

        new_dino_list.push(dino)
      end
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

  def main(args)
    # load data from csv
    dinodatabase = Dinobase.new

    dinodatabase.parse_dinodex
    dinodatabase.parse_african_dinos

    final_dinosaurs_list = Array.new(dinodatabase.dinosaurs)

    if args.include?("--help") || arg_does_not_exist(args)
      display_usage
      return
    end

    if args.include? "-b"
      final_dinosaurs_list = filter_bipeds(final_dinosaurs_list)
    end

    if args.include? "-c"
      final_dinosaurs_list = filter_carnivors(final_dinosaurs_list)
    end

    if args.include? "-s"
      final_dinosaurs_list = filter_small(final_dinosaurs_list)
    elsif args.include? "-B"
      final_dinosaurs_list = filter_big(final_dinosaurs_list)
    end

    if args.include? "--period"
      index_of_period_arg = args.index("--period")
      periodParam = args[index_of_period_arg + 1]

      final_dinosaurs_list = filter_period(final_dinosaurs_list, periodParam)
    end

    if args.include? "--search"
      indexOfSearchArg = args.index("--search")
      searchParam = args[indexOfSearchArg + 1]

      final_dinosaurs_list = filter_search(final_dinosaurs_list, searchParam)
    end

    # finally we export our work
    if args.include? "--json"
      json_export(final_dinosaurs_list)
    else
      text_export(final_dinosaurs_list)
    end
  end
end

# creating a new dinocall and passing args
dinocall = Dinocalls.new
dinocall.main(ARGV)
