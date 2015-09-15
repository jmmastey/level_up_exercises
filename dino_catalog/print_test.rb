require_relative "dino_dex"

dino_dex   = DinoDex.new
dino_files = FileFinder.new(".", "*.csv")
dino_files.files.each { |file_path| dino_dex.import_csv_file(file_path) }

puts "[Bipeds]"
dino_dex.select("walking", "biped").print_data("name")
puts "`````````````"

puts "[Carnivores]"
dino_dex.select("diet", "carnivore").print_data("name")
puts "`````````````"

puts "[Cretaceous]"
dino_dex.select("period", "cretaceous").print_data("name")
puts "`````````````"

puts "[Chain Filter: Jurassic + Carnivores]"
dino_dex.select("period", "jurassic").filter("diet", "carnivore").print_data(["name", "period"])
puts "`````````````"

puts "[> 2000 lbs]"
dino_dex.select_larger_than(2000).print_data(["name", "weight"])
puts "`````````````"

puts "[< 500 lbs]"
dino_dex.select_smaller_than(500).print_data(["name", "weight"])
puts "`````````````"

puts "[Dinosaur Facts -> Yangchuanosaurus]"
puts dino_dex.select_dinosaur("yangchuanosaurus").export_facts
puts "`````````````"

puts dino_dex.to_json
