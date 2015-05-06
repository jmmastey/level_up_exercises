class DinoDex
  require 'csv'
  require 'json'

  @@dino_database = []

  # Read main CSV file into an array of hashes

  CSV.foreach('dinodex.csv', headers: true) do |row|
    @@dino_database << row.to_hash
  end

  # Read Pirate Bay CSV file and merge the results

  # COME BACK TO THIS!!

  # pb_csv = CSV.read('african_dinosaur_export.csv', headers: true)
  # pb_headers = pb_csv.headers.map do |header|
  #   case header.downcase
  #     when 'carnivore'
  #       'DIET'
  #     when 'genus'
  #       'NAME'
  #     when 'weight'
  #       'WEIGHT_IN_LBS'
  #     else
  #       header.upcase
  #   end
  # end
  # p CSV.header_convert(pb_headers).read('african_dinosaur_export.csv', headers: true)

  CSV.foreach('african_dinosaur_export.csv', headers: true) do |row|
    diet = row['Carnivore'].downcase == 'yes' ? 'Carnivore' : nil

    @@dino_database << {
      NAME: row['Genus'],
      PERIOD: row['Period'],
      CONTINENT: nil,
      DIET: diet,
      WEIGHT_IN_LBS: row['Weight'],
      WALKING: row['Walking'],
      DESCRIPTION: nil,
    }
  end

  # Analyze key/value and generate results properly

  def generate_results(key, value)
    if value.class == Array
      results_from_array(key, value)
    elsif key == 'min_weight'
      results_from_min_weight(value)
    else
      results_from_string(key, value)
    end
  end

  # Match against multiple string values

  def results_from_array(key, array_of_values)
    array_of_values_dl = array_of_values.map(&:downcase)
    @@dino_database.select do |dino|
      dino[key] && array_of_values_dl.include?(dino[key].downcase)
    end
  end

  # We treat min_weight differently than a regular string match

  def results_from_min_weight(min_weight)
    @@dino_database.select do |dino|
      dino[:WEIGHT_IN_LBS] && dino[:WEIGHT_IN_LBS].to_i >= min_weight
    end
  end

  # Match against string value

  def results_from_string(key, value)
    @@dino_database.select do |dino|
      dino[key] && dino[key].downcase.include?(value.downcase)
    end
  end

  # Search for dinosaurs based on various criteria

  def search(search_filters)
    results = []
    search_filters.each do |key, value|
      results.push(generate_results(key, value))
    end
    puts results.to_json
  end
end

dinodex = DinoDex.new

# Grab all dinosaurs that were bipeds
dinodex.search('WALKING' => 'Biped')

# Grab all the dinosaurs that were carnivores (fish and insects count).
dinodex.search('DIET' => %w(Carnivore Insectivore Piscivore))

# Grab dinosaurs for specific periods
dinodex.search('PERIOD' => 'Cretaceous')

# Grab only big (> 2 tons) or small dinosaurs.
dinodex.search('min_weight' => 2000)

# Print out details of a specific dinosaur
dinodex.search('NAME' => 'Albertonykus')
