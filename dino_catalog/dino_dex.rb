require_relative "dino_catalog.rb"
require 'csv'
require 'json'

class DinoDex
  DINO_DATA_DIR = 'dino_data'
  EMPTY_FIELD = '(null)'

  def initialize
    @catalog = DinoCatalog.new
  end

  def search(filters = {})
    @catalog.dinos_where filters
  end

  def catalog_all_dino_data
    @catalog.reset_data
    dino_data_dir_path = "#{DINO_DATA_DIR}/*.csv"
    Dir.glob(dino_data_dir_path).each(&method(:catalog_dino_csv))
  end

  def catalog_dino_csv(csv_file)
    dino_data = CSV.read(csv_file, encoding: "UTF-8", headers: true,
                                  header_converters: :symbol, converters: :all)
    dino_data.map { |dino| @catalog.catalog_dino dino.to_hash }
  end

  def export_dinos_as_json
    @catalog.all_dinos.to_json
  end

  def print_dinos(dinos)
    header_row = dinos.flat_map(&:keys).uniq

    print_row(header_row.map(&:upcase))
    dinos.each do |dino|
      print_row(header_row.map { |h| dino.fetch(h, EMPTY_FIELD) })
    end
  end

  private

  def print_row(fields)
    puts "\r\n"
    fields.each { |f| print "#{f}\t" }
  end
end

# ========== TESTS =============
dino_dex = DinoDex.new
dino_dex.catalog_all_dino_data

# answer these things for me:
#     * Grab all the dinosaurs that were bipeds.
puts "\n============ Grab only bipeds =============="
puts dino_dex.search(walking: 'Biped')

#     * Grab all the dinosaurs that were carnivores (fish and insects count).
puts "\n============ Grab only carnivores =============="
puts dino_dex.search(carnivore: 'yes')

#     * Grab dinosaurs for specific periods (no need to
# differentiate between Early and Late Cretaceous, btw).
puts "\n============ Grab specific period =============="
puts dino_dex.search(period: 'Late Cretaceous')

puts "\n============ Grab general period =============="
puts dino_dex.search(period_name: 'Cretaceous')

#     * Grab only big (> 2 tons) or small dinosaurs.
puts "\n============ Grab only big dinosaurs =============="
puts dino_dex.search(size: 'big')

#     * Just to be sure, I'd love to be able to combine criteria at will,
# even better if I can chain filter calls together.
puts "\n====== Chaining filters continent: 'North America',"\
      "diet: 'Carnivore', size: 'small', walking: 'Quadruped' ========"
puts dino_dex.search(continent: 'North America', diet: 'Carnivore',
  size: 'small', walking: 'Quadruped')

# 3. For a given dino, I'd like to be able to print all the known
# facts about that dinosaur. If there are facts missing, please don't
# print empty values, just skip that heading. Make sure to print
# Early / Late etc for the periods.
# 4. Also, I'll probably want to print all the dinosaurs in a given
# collection (after filtering, etc).
puts "\n========== Printing table of filtered collection results' ============"
dino_dex.print_dinos dino_dex.search(continent: 'North America',
                                        diet: 'Carnivore')

# 5. CSV isn't may favorite format in the world.
# Can you implement a JSON export feature?
puts "\n============ Exporting dinosaurs as json =============="
puts dino_dex.export_dinos_as_json
