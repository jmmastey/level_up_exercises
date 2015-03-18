load 'dinosaur.rb'
load 'dinosaur_data_parser.rb'
load 'dino_catalog.rb'

files_to_read = ["dinodex.csv", "african_dinosaur_export.csv"]
dino_catalog = DinoCatalog.new(DinosaurDataReader.new(files_to_read).dinosaurs)
option = ARGV[0]
criteria = ARGV.to_s

def displayUsage
  puts "Usage:\nruby dinodex.rb <search_options>\n-w  <WALK_TYPE>\t\t\treturn all <WALK_TYPE> dinosaurs\n-d  <DIET_TYPE>\t\t\treturn all <DIET_TYPE> dinosaurs"
  puts "-a\t\t\t\treturn dinosaur collection\n-n  <NAME>\t\t\treturn facts for this dinosaur\n"
  puts "-b\t\t\t\treturn dinosaurs weighing more than 2 tons\n-s\t\t\t\treturn dinosaurs weighing less or equal to 2 tons\n-p  <PERIOD>\t\t\treturn dinosaurs in this <PERIOD>"
  puts "You can also combine the criteria\nExample 1: ruby dinodex.rb -w Biped -d Carnivore -p Late\twill return all biped dinosaurs that are carnivores in 'Late' period."
  puts "Example 2: ruby dinodex.rb -w Biped -b\twill return all biped dinosaurs who weigh more than 2 tons."
end

def is_valid_option(criteria)
  if criteria.include?("-w") ||
      criteria.include?("-d") ||
      criteria.include?("-n") ||
      criteria.include?("-b") ||
      criteria.include?("-s") ||
      criteria.include?("-p") ||
      criteria.include?("-a")
  return true
  end
end

unless option.nil?    
  dino_catalog = DinoCatalog.new(dino_catalog.get_walking(criteria)) if criteria.include?("-w")
  dino_catalog = DinoCatalog.new(dino_catalog.get_diet(criteria)) if criteria.include?("-d")
  dino_catalog = DinoCatalog.new(dino_catalog.get_specific_dinosaur(criteria)) if criteria.include?("-n")
  dino_catalog = DinoCatalog.new(dino_catalog.get_big_dinosaurs) if criteria.include?("-b")
  dino_catalog = DinoCatalog.new(dino_catalog.get_small_dinosaurs) if criteria.include?("-s")
  dino_catalog = DinoCatalog.new(dino_catalog.get_period_specific_dinosaurs(criteria)) if criteria.include?("-p")
  dino_catalog = DinoCatalog.new(dino_catalog.get_dinosaur_collection) if criteria.include?("-a")
  puts "\n"

  if is_valid_option(criteria)
    dino_catalog.print_filtered_catalog
  else
    displayUsage
  end
else
  displayUsage
end

